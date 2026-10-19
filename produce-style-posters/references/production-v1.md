# 平台生产契约 v1（已撤回的可选契约）

## 状态：非当前可用接口
用户已撤回本轮工作台升级，恢复原工作台；聊天 skill 保留。以下仅为历史可选契约，不可假设 production CLI、脚本或 HTTP 路由仍存在，也不得自行重建。默认执行聊天看图、双版提示词、真实生图与文件交付；归档、原杂交与发文程序须运行时检查当前接口。只有另获启用授权并核验实现后才采用下列命令。

## 入口与职责
以下命令在用户已授权、已连接的本机项目根目录，经本地执行子任务运行。聊天助手执行看图、转写、生图和审美迭代，平台不执行模型反推或生图。先核验脚本与契约仍存在。

```sh
node scripts/production.mjs create --title '本期风格' --reference '/绝对路径/参考.png' --input '用户原始需求'
node scripts/production.mjs status --id RUN_ID
node scripts/production.mjs import-result --id RUN_ID --file assistant-result.json
```

多参考重复 --reference，或 create --file create.json，文件为 {title,input,references:[{path,name,source:{type:'library',library_file_id:'实际ID'}}]}。create 返回 run.id 和 references[].id/path/sha256/source。不得虚构ID。

## 结果包
```json
{
  "schema_version": 1,
  "run_id": "实际run ID",
  "analysis": {
    "observations": [{"reference_id":"实际ref ID","findings":["逐图实际观察"]}],
    "common_rules": [], "conflicts": [], "resolutions": [],
    "transferable_rules": [], "excluded_content": []
  },
  "version": {
    "structured_prompt": {
      "system_role":"角色", "task_description":"任务",
      "input":{"brand_or_theme":"用户只输入品牌或主题"},
      "workflow":[], "design_specifications":{"overall_style":"实际规则"},
      "dynamic_variables":{"text_elements":"自动补英文识别词、中文标题与中文短句；准确文案照录"},
      "output_requirement":"不编活动事实；通用prompt不锁画幅"
    },
    "natural_language":{"zh":"完整连贯中文；en为可选字段"},
    "parent_version_ids":[], "lineage":{"parents":[],"parameters":{}},
    "notes":"取舍与限制"
  }
}
```
以上是接口示例，不是可发布风格或真实证据。分析须逐图引用返回ref ID。任一Prompt改变创建新版本，旧测试不算本轮通过。也可使用 analyze --file（文件含analysis）和 version --file（版本对象）分步导入。

## 真实测试
```sh
node scripts/production.mjs prepare-test --id RUN_ID --variant structured --input NIKE --kind minimal
node scripts/production.mjs prepare-test --id RUN_ID --variant natural_zh --input NIKE --kind minimal
node scripts/production.mjs record-test --id RUN_ID --file evidence.json
```
prepare-test 返回 run.tests[]，包括 id/version_id/prompt_hash/variant/case_kind/user_input/actual_input/actual_input_hash/generation_settings/reference_ids/status/prepared_at。将 actual_input 全文原样传入生成工具，不再拼文案、风格或参考图。工具有独立比例参数才在那里设置；否则记录 provider_default，不能假称指定画幅。若工具上下文不能隔离则披露。

```json
{
  "test_id":"实际test ID",
  "evidence": {
    "path":"消费端本机实际新图路径",
    "provider":"实际提供者",
    "model":"实际模型或not_exposed_by_tool",
    "generation_id":"实际调用ID",
    "generated_at":"实际ISO时间",
    "actual_input":"prepare-test全文原样",
    "generated_new":true,
    "receipt":{"tool":"实际调用","reference_images":[]},
    "limitations":[]
  },
  "visual_review":{"result":"revise","reviewer":"实际评审人","notes":"像素结论","limitations":[]}
}
```
浏览器可用 evidence.image_data base64代替path。云端文件须先通过受支持传输交给本地任务，不能将云路径当Mac路径。平台复制图像并校验hash。visual-review 可稍后提交。无图用 block-test，文件为 {test_id,reason}；旧图/参考图/同hash历史图不能冒充新图。

当前各Prompt语言版本的minimal有真图且像素评审passed后，才可登记用户明确的 review：{decision:'approved',reviewer:'用户',notes:'真实用户决定'}。不得自动替用户批准。若用户要求修改，保留revise并回调；平台门槛不替代本skill的品牌/主题迁移覆盖要求。

## 审核后生产与衔接
- candidates 默认10品牌+10主题；select --file 的文件为 {candidate_ids:[...]}，保存用户选择。
- 候选测试 kind=candidate、传candidate_id。首尾 kind=cover/closing，input为设计提示词分享/DESIGN HAPPY。正式图使用structured。
- export 导出Prompt与经验文件；22张需要20候选实图、独立首尾和用户审核。缺项显示pending，不默认ZIP。
- notion-preview 仅生成 handoff/notion-plan.json，不写远端。已授权归档可执行 node scripts/production.mjs notion-sync --id RUN_ID --execute，复用既有个体库/实验库和字段，不创建schema。
- notion-sync 只使用现有 NOTION_TOKEN 或 NOTION_API_KEY，不配置或显示密钥；缺少凭据返回blocked，可交已有授权聊天连接器写入并回填，不自动安装连接器。先检查所有声明图片的路径、格式、SHA256，再上传参考图和实测原图；核验已上传ID与当前摘要绑定后可复用。handoff/notion-image-uploads.json保存回执，不保存密钥或签名图片URL。上传中断保留partial和成功图片ID，不标归档成功。
- 图片上传后按run+version稳定ID生成计划并幂等写档。正文分批追加，handoff/notion-ledger.json保存已完成进度与远端指纹；同内容重跑查询复核后跳过或续写。只有完整synced才登记当前版本archiveReceipt；failed/blocked/needs_review/partial不改变生成、像素评审或用户定稿状态。
- 默认不覆盖同ID内容。用户已授权更新本流程拥有的草稿时，可追加 --allow-update-owned；ledger须证明当前run创建该页、保存完整旧正文及属性指纹，且远端仍匹配。更新保留旧正文，追加确定修订段并核验完整后再提交属性。归属不明、人工改动、重复稳定ID或其他待恢复修订冲突返回needs_review。Notion无原子条件更新，记录检查后仍可能并发编辑的限制。已有明确授权不重复索要。
- 恢复沿用同run、版本、图片回执和ledger重跑相同同步命令，不删历史。连接器执行者可消费plan.records或调用 applyNotionSyncPlan(plan,{transport,approval,ledger})，随后用archive-receipt回填当前版本真实page ID/URL/content_hash与完整结果。预览或单独上传图片均不是完整归档成功。
- hybrid-export 仅生成handoff草稿，保留prompt_template、来源/父版本/参数/validation。审核后hybrid-import显式写入inbox且未评分。hybrid-link接真实children JSON，子代新版本仍要重写公开版并生图。
- post-preview准备交接；post-execute --action brief --execute执行本地brief。process要求 --allow-external-write --model MODEL --model-verified，只有本次真实验证过模型可填verified；先确认外部调用授权与费用。写current前快照和共享锁，恢复用post-restore --file，文件含实际snapshot_path。save_inputs可传准确英文JSON/小红书/推特文案给save。新译文若被采纳为Prompt必须另立版本再测。无自动发帖、部署、推送。

## HTTP 与状态
GET /api/production -> {runs}；GET /api/production/run?id=RUN_ID -> {run}；POST /api/production/create接受创建对象；POST /api/production/action接受{id,action,...payload}，动作同CLI。文件GET /api/production/file?id=RUN_ID&path=任务相对路径。写请求仅本机同源。结果{run,result?}。任务文件production/runs/RUN_ID/run.json。不得猜端口或混用旧实例。
