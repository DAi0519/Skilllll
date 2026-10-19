#!/usr/bin/env python3
"""Validate structural evidence, never judge pixels or infer owner approval."""
import argparse
import hashlib
import json
from pathlib import Path


def validate(records, base):
    errors = []
    if not isinstance(records, list) or not records:
        return ['records must be a nonempty array']
    for i, r in enumerate(records):
        prefix = f'record {i + 1}: '
        if not isinstance(r, dict):
            errors.append(prefix + 'must be an object')
            continue
        def fail(message):
            errors.append(prefix + message)
        required = ['variant', 'version', 'theme', 'case_type', 'prompt_file', 'input_file',
                    'prompt_sha256', 'input_sha256', 'evidence_type', 'image_files',
                    'reference_images_used', 'extra_instructions', 'isolated_input',
                    'visual_status', 'approval_status']
        for key in required:
            if key not in r:
                fail('missing ' + key)
        texts = {}
        for kind in ['prompt', 'input']:
            try:
                p = base / r[kind + '_file']
                raw = p.read_bytes()
                texts[kind] = raw.decode('utf-8')
                if hashlib.sha256(raw).hexdigest() != r.get(kind + '_sha256'):
                    fail(kind + ' hash mismatch')
            except (OSError, KeyError, TypeError, UnicodeError):
                fail(kind + ' file unavailable or invalid UTF-8')
        if 'prompt' in texts and 'input' in texts:
            expected = texts['prompt'].rstrip() + '\n\n品牌/主题：' + str(r.get('theme', ''))
            if r.get('prepared_input_file'):
                try:
                    expected = (base / r['prepared_input_file']).read_bytes().decode('utf-8')
                except (OSError, TypeError, UnicodeError):
                    fail('platform prepared input unavailable or invalid')
            if texts['input'] != expected:
                fail('input differs from the authoritative prepared input')
        if r.get('reference_images_used') is not False or r.get('extra_instructions') != []:
            fail('minimal-input test includes references or extra instructions')
        if r.get('isolated_input') is not True:
            fail('independent minimal-input isolation not established')
        if r.get('evidence_type') != 'real_new_generation':
            fail('not real new generation evidence')
        for key in ['tool', 'generated_at', 'tool_receipt']:
            if not r.get(key):
                fail('missing generation evidence ' + key)
        files = r.get('image_files', [])
        if not isinstance(files, list) or not files:
            fail('missing images')
        else:
            for f in files:
                try:
                    if not (base / f).is_file() or (base / f).stat().st_size == 0:
                        fail('image missing or empty: ' + str(f))
                except TypeError:
                    fail('invalid image path')
        if r.get('visual_status') not in ['pending', 'pass', 'fail']:
            fail('invalid visual_status')
        if r.get('approval_status') not in ['pending', 'approved', 'rejected']:
            fail('invalid approval_status')
        if r.get('visual_status') == 'pass':
            checks = r.get('checks', {})
            required_checks = ['typography', 'shapes', 'palette', 'background', 'spacing', 'copy_layers', 'theme_transfer', 'accuracy']
            if any(not isinstance(checks.get(k), dict) or checks[k].get('status') != 'pass' or not checks[k].get('evidence') for k in required_checks):
                fail('visual pass lacks complete documented checks')
        if r.get('approval_status') == 'approved' and not r.get('approval_source'):
            fail('approval lacks owner source')
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('records', type=Path)
    args = parser.parse_args()
    try:
        records = json.loads(args.records.read_text(encoding='utf-8'))
        errors = validate(records, args.records.parent)
    except (OSError, ValueError) as exc:
        errors = [str(exc)]
    print(json.dumps({'structural_validation': 'fail' if errors else 'pass', 'errors': errors,
                      'limit': 'Does not verify pixels, tool receipts, coverage, or owner approval authenticity.'}, ensure_ascii=False, indent=2))
    return bool(errors)


if __name__ == '__main__':
    raise SystemExit(main())
