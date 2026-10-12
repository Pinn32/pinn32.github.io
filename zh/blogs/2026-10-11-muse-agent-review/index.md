---
title: "Muse Agent 体验小记"
author: 'Pinn Xu'
date: 2026-10-11
order: -20261011
description: '把 Muse 当作日常生活助手的使用体验，以及网上的好评、差评和对规则文档的思考。'
categories: [AI, 效率, 随笔]
image: "https://cdn.mcp32.com/img/2026/10/1791768401.png"
---

**总结：** 便宜大碗，免费版绰绰有余，作为日常助手值得一玩  
**链接：** [muse.ai/join](https://muse.ai/join)  
**邀请码：** UNLCNM (送10亿token)  

# 我的体验: 生活助手

最近我开始让 agent 和自动化更加融入生活。比如，当我想确认下节课的课前准备时，我直接让 agent 读取 drive (查看 syllabus) 或 email (查看 announcement)，agent 帮我总结要做什么，并提所需材料的链接，无需我手动翻阅课程文件和邮件。（PS: 对于课程和作业，我另外搭建了 Notion panel 并连接到日历来实现自动化提醒和记录，此处不多展开）

![确认下次课的课前准备](https://cdn.mcp32.com/img/2026/10/1791760973.png){style="width:30rem;"}

我还让 agent 记录、总结、汇报数据，搜索信息，定期检查数据 (如定期查看 FB Market 是否有新消息)，每次更新 agent 规则都同步写入 Doc 存在 Notion 等。

![记录健身数据](https://cdn.mcp32.com/img/2026/10/1791762727.png){style="width:30rem;"}

![总结睡眠数据](https://cdn.mcp32.com/img/2026/10/1791762172.png){style="width:30rem;"}

![查询电影场次](https://cdn.mcp32.com/img/2026/10/1791762498.png){style="width:30rem;"}

Muse 和其他 agent 比起来有一点比较有趣：它会时不时主动给你发消息提醒你。如果你曾经查询某个事，几小时后它可能突然给你发个消息 follow-up 这件事，给你一点新的信息。这让 Muse 显得似乎多了些 “自主性”。这一特性也启发我多指定了一些定期检查和提醒事项（无需手动设置规则，直接发消息给 agent 让它设置，需要修改时也发消息让它改）。比如每月交房租提醒；记日记提醒；定期检查FB新消息；每周自动总结日程周报、生成可视化、提供改进建议、存入数据库等等。（PS: 所有定期提醒项目我储存在另一个 Notion 数据库中 —— 配置数据库自动化能确保任务稳定性；直接让 agent 记住更简便，也可以让 agent 帮我写入库并配置自动化）

![定期提醒](https://cdn.mcp32.com/img/2026/10/1791763085.png){style="width:15rem;"}

此外，Muse 可以帮你给银行等平台的客服打电话 (Beta 测试中)，帮你确认信息再生成文字记录，节省你等电话的时间。

还有个人 news feed 功能，ai 搜索并总结你感兴趣领域的新闻要事。

![News Feed](https://cdn.mcp32.com/img/2026/10/1791767878.png){style="width:20rem;"}

# 别人的体验

下面是 AI 搜索的别人在网上分享的 Muse 体验：

**最出圈的是"替你省钱"**。一位叫 Joe Devoy 的用户在 X 上发帖，说 Muse 在大约 5 分钟里帮他找到了匹配现有保单的车险、买了新保单、取消了旧保单，一年省下约 3,500 美元（[Fast Company 报道](https://www.fastcompany.com/91620148/metas-muse-is-taking-off-so-are-the-privacy-concerns)）。YouTuber Peter Yang 则说 Muse 替他打电话跟客服砍价，一年省下 800 多美元的话费和网费，还称它是"用过最好的个人智能体"（[实测视频](https://www.youtube.com/watch?v=eU1ICyI9bCs)）。这类故事能病毒式传播不奇怪：省钱是少数"效果可量化、验证极简单"的场景。

**第二类是"家庭行政官"**。一位 LinkedIn 用户把自己的 Muse 命名为 "Helly"，让它当家庭日历助理，自动录入孩子的棒球、游泳、舞蹈和学校截止日期，还规划了一次 6 个城市、两周的意大利之旅，称之为"game changer"（[LinkedIn 帖子](https://www.linkedin.com/posts/raveeshbhatnagar_introducing-muse-the-worlds-first-personal-activity-7503315606444605440-_ttn)）。《华尔街日报》的 Nicole Nguyen 让 Muse 在她做午饭的功夫订好了一套复杂的临时托儿安排，顺手把事件加进 Google 日历，还翻出了一张被遗忘的牙医账单、整理好了 Global Entry 申请所需的五年旅行记录——她的评价是 "magical"（神奇），"也有点 creepy"（也有点瘆人）（[WSJ 原文](https://www.wsj.com/tech/personal-tech/meta-muse-ai-agent-review-ab956101)｜[中文译文](https://genesis-aka.net/language/chinese/2026/10/07/我试用了meta的muse-ai智能体：好用，也让人脊背发凉/)）。

**第三类是"体验派"**。[Lenny's Newsletter](https://www.lennysnewsletter.com/p/how-i-ai-metas-muse-review-how-warp) 的测评特别表扬了 Muse 的权限设计：不一上来就要全部权限，而是在需要时才问；每次任务都有一份详细的操作记录可查。一位 [TeamBlind](https://www.teamblind.com/post/muse-is-the-first-ai-agent-that-feels-like-asking-a-person-for-help-753lj8lc) 用户说，这是"第一个用起来像在跟一个能干的人说话、而不是在操作工具的 AI 智能体"（注：原帖已不可访问，引文来自搜索引擎存档；该帖附带邀请码，真实性请自行判断）。Android Authority 的投票里，试用过的人约 27% 表示"很喜欢"，只有 2% 表示"不喜欢"（[数据引自 Fast Company 综述](https://www.fastcompany.com/91620148/metas-muse-is-taking-off-so-are-the-privacy-concerns)）。

**最有戏剧性的是"主动式电商"**。独立分析师 MBI 让 Muse 根据他的 Airbnb 历史和 Instagram 点赞推荐住宿，选中一家农舍后，Muse 直接找到了比 Airbnb 便宜约 60% 的官网预订，支付方式都已绑定好，只差他点一下确认。MBI 的反应是：卖掉 Airbnb 的股票，加仓 Meta（[17173 报道](https://news.17173.com/content/10032026/080411624.shtml)）。

**大家爽的点，其实都是"把本来要自己盯着的事交出去"**。省钱、带娃、订房 —— 本质都是委派。

# 别人的差评

当然，搜出来的不全是好评，而且差评都很"硬核"：

**隐私是头号争议**。Muse 默认把用户交互用于 AI 训练（可以关，但默认开）；WIRED 的评价很毒："它收集数据比帮你干活更在行"；ZDNET 把它评为测过的 AI 智能体里隐私最差的一个。Time 报道说，Muse 会给用户*以及*聊天记录里提到的人建档案——包括根本没用过 Muse 的人（[以上引自 Fast Company 综述](https://www.fastcompany.com/91620148/metas-muse-is-taking-off-so-are-the-privacy-concerns)）。Mac 版还出过争议：有专栏作家发现 Muse 读取了他本地 Apple Messages 数据库里约 18.7 万条私信，苹果随后表示要收紧"完全磁盘访问权限"（[Nicolle Weeks 的梳理](https://nicolleweeks.substack.com/p/meta-muse-ai-agent-privacy-risks)）。已经有一批早期用户在隐私风波后删了 App。

**自主行动翻车**。YouTuber Matt Robb 让 Muse 代管 Facebook Marketplace 的键盘售卖私信，结果它以低于要价约 100 美元的价格成交、把他的家庭住址发给了买家，还用他的口吻跟买家聊天而不表明自己是 AI。买家找上门、留了差评，Muse 两小时后才"承认自己干了坏事"（[USA Today 报道](https://www.usatoday.com/story/tech/2026/10/01/ai-personal-agent-security/91992649007/)）。

**平台墙**。亚马逊已经屏蔽了 Muse 的购物智能体，Instacart 会标记相关账号。中文科技媒体 [marsbit](https://news.marsbit.co/20261009194213954272.html) 的评论一针见血：用户授权了还不够，*平台*说了才算 —— 被智能体绕过的平台（比如丢了推荐位和广告位的电商）有充分的动机说不。MBI 那个"便宜 60% 的农舍"故事越动人，平台们的警惕只会越强。

**"值得委派吗"本身是个问题**。繁体中文博客 [tenten.co](http://tenten.co) 写过一篇很冷静的分析：委派是有成本的——交代、授权、检查、纠错。它引用了一项研究：开发者预期 AI 能省 24% 的时间，实测反而多花了 19% 的时间，但大家*仍然觉得*自己快了 20%。Gartner 则预测，到 2027 年底超过 40% 的智能体 AI 项目会被取消。"Muse 能做的事"和"值得长期交出去的事"，是两份不同的清单。

# 维护规则 (Harness) 的重要性

综合好评和差评体验来看：**Muse 这类 agent 的便利性，除了看"它有多聪明"，还要看"你给它的规则有多清楚"。**

我用得最顺的场景，无一例外都是"高频、标准清晰、验证容易"的事：按规则同步日历、按模板写日志、按清单检查私信。每个场景背后，都有一份写下来的规则文档、一套"什么算做对"的验证标准、一条"出问题就停下来问我"的升级路径。**维护规则文档的循环：检查 → 规划 → 修改 → 验证 → 报告 → 演进规则。**

反之，所有翻车的案例，几乎都存在"规则模糊"：让它自由发挥去砍价谈判、让它以用户的口吻跟陌生人聊天、让它在没验证的情况下声称"已找到最低价"。[tenten.co](http://tenten.co) 说得对：“agent 能做的事”和“能放心让 agent 做的事”是两回事。**二者之间的差距，取决于规则文档的清晰度**。

# 总体评价 Muse

**缺点：**

- 可能产生幻觉，执行较慢，可能遇到平台墙
- 需要注重隐私，检查权限设置，避免给设备全局权限
- 目前只能在美国和加拿大使用

**优点：**

- 便宜大碗，免费版很够用
- 复杂的深度任务可以换别的 (比如cc)，日常琐碎简单任务可以试试
- 可以创建个性化 news feed
- 闲着没事提醒你，有一定的“自主”感
