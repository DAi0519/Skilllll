# 提示词与验证规范

## 同源记录建议
保存 style_id、version、parent_version、reference_assets、DNA、conflicts、input_contract、production_json、public_prose_zh、public_prose_en（可选）、validation_records、approval。这些是聊天产物的概念字段，不是平台已支持的 API 契约。

JSON 的 input_contract 明确 required=[brand_or_theme]，optional=[exact_copy,aspect_ratio,real_event_facts]。自动文案规则包含 headline、short_phrase、supporting_copy，长度应随风格与画幅适配。不要把一次测试的品牌与文案写成通用默认。

自然语言将文案生成融入完整段落，例如说明“仅给品牌或主题时，先为该主题创作主标题、一句短句和少量辅助文字，再按照上述层级排版；没有真实活动信息时使用不带事实承诺的主题表达”。不要依赖这句话之外的私下补充。

## 验证记录
每项记录保存独立对象：
- variant: production_json 或 public_prose_zh/public_prose_en
- version、theme、case_type: brand 或 theme
- prompt_file: 冻结的通用提示词 UTF-8 文件
- input_file: 实际工具完整文本输入 UTF-8 文件
- prompt_sha256、input_sha256
- evidence_type: real_new_generation / historical / mock / text_only
- image_files: 真实输出文件列表
- reference_images_used: 是否实际传入参考图
- extra_instructions: 额外指令数组；最小输入测试必须为空
- isolated_input: 工具调用是否不带其他隐式会话/图片上下文
- tool、generated_at、tool_receipt: 可核验的调用/回执引用
- checks: 字体/形态/配色/底色/留白/三层文案/主题迁移/准确性，每项 pass/fail/unknown 与具体证据
- visual_status: pending/pass/fail
- approval_status: pending/approved/rejected；approval_source: 用户真实批准消息引用

独立聊天测试（未使用平台 prepare-test）的最小输入文件严格为：通用提示词原文（去掉末尾空白） + 两个换行 + “品牌/主题：” + theme。所有任务专属参数作为显式元数据记录，不能藏进输入。

每条记录本身不意味着样本充分。只在两版各有品牌与不同类主题的新生成、人工检查通过后称完成本轮迁移验证。若用户缩小测试范围，明确覆盖面，不能宣称全面通过。英文提示词作为独立版本；生成后同样验证，不以翻译检查代替。

## 回调
失败时记录观察到的症状与原图证据，定位最少必要约束，修改同源记录和受影响版本，再冻结重新生成。对外提交实际输入原文，方便用户复现。检验“只有主标题”时优先检查自动补全三层文案是否写进公开版本，而不是先归因于随机性。

平台 prepare-test 模式：保留平台返回的 actual_input 全文为 prepared_input_file；input_file 必须逐字相同。校验脚本会优先比对该文件。人工确认 prepare-test 的版本、prompt_hash、reference_ids 与 generation_settings，禁止以自行构造 prepared_input_file 掩盖私下补充。平台 evidence 映射见 production-v1.md；内部结构检查记录不是平台 record-test payload。
