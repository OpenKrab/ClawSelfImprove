---
name: claw-selfimprove
description: "Enhanced self-improving loop for OpenKrab with ClawMemory integration, Thai support, and safety guardrails. Captures learnings, errors, and corrections for continuous AI agent improvement."
metadata:
  version: "1.0.0"
  author: "OpenKrab"
  license: "MIT"
  repository: "https://github.com/openkrab/claw-selfimprove"
  tags: ["self-improvement", "openclaw", "clawmemory", "thai-support", "ai-agent"]
  dependencies: ["clawmemory", "clawflow"]
---

# ClawSelfImprove - Enhanced Self-Improving Loop

**ClawSelfImprove** is an advanced self-improvement system for OpenClaw agents, extending the popular self-improving-agent with ClawMemory integration, Thai language support, and enhanced safety features.

## 🚀 Key Features

- **Continuous Learning**: Captures errors, corrections, and insights automatically
- **ClawMemory Integration**: Vectorizes learnings for intelligent retrieval
- **Thai Language Support**: Full Thai prompt templates and auto-translation
- **Safety Guardrails**: Human review required for major changes
- **ClawFlow Ready**: One-click installation via ClawFlow
- **Cross-Session Memory**: Learnings persist across all agent sessions

## 📊 Stats (Forked from Popular Base)

- **Base Downloads**: 32K-37K+ (self-improving-agent on ClawHub)
- **Base Stars**: 338-441 (highest-rated skill on ClawHub)
- **Enhanced Features**: ClawMemory + Thai + Safety
- **Active Maintenance**: Weekly updates

## 🎯 Quick Reference

| Situation | Action | Location |
|-----------|--------|----------|
| Command fails | Log error | `.learnings/ERRORS.md` |
| User corrects you | Log learning | `.learnings/LEARNINGS.md` |
| Thai correction | Auto-translate | `.learnings/LEARNINGS-TH.md` |
| Major learning | Promote + Review | `SOUL.md`/`AGENTS.md` |
| Weekly review | Generate report | `ClawMemory` graph |

## 🛠 Installation

### Via ClawFlow (Recommended)
```bash
clawflow install claw-selfimprove
```

### Manual Installation
```bash
git clone https://github.com/openkrab/claw-selfimprove ~/.openclaw/skills/claw-selfimprove
mkdir -p ~/.openclaw/workspace/.learnings
```

## 🏗 Architecture

```
ClawSelfImprove/
├── hooks/                 # OpenClaw hooks
│   ├── bootstrap.sh       # Session start reminders
│   └── post-tool-use.sh   # Error detection
├── scripts/               # Helper scripts
│   ├── activator.sh       # Emit reminders
│   ├── error-detector.sh  # Scan for errors
│   └── promote.py         # AI-powered promotion
├── templates/             # Prompt templates
│   ├── reminder.md        # Session reminders
│   ├── learning-entry.md  # Learning format
│   └── thai-prompts.md    # Thai language support
├── .learnings/            # Learning storage
└── ClawFlow.yaml          # Installation metadata
```

## 🧠 ClawMemory Integration

Learnings are automatically vectorized and stored in ClawMemory graph:

```python
# Example: Learning becomes graph node
{
  "type": "learning",
  "content": "Use async/await instead of .then() for API calls",
  "category": "best_practice",
  "language": "en",
  "vector": [0.1, 0.2, ...],
  "relationships": ["javascript", "api-calls", "async-patterns"]
}
```

## 🇹🇭 Thai Language Support

Full Thai integration with automatic detection:

```markdown
## [LRN-20260302-001] correction (thai)

**Logged**: 2026-03-02T14:00:00+07:00
**Language**: th
**Priority**: high

### สรุป (Summary)
ใช้ async/await แทน .then() สำหรับ API calls

### รายละเอียด (Details)
User แก้ไขว่าควรใช้ async/await pattern...
```

## 🔒 Safety Features

- **Human Review**: Major changes require confirmation
- **Dry Run Mode**: Test without applying changes
- **Rate Limiting**: Max 5 reflections per session
- **Privacy Filter**: Sensitive data detection
- **Rollback Support**: Undo unwanted promotions

## 📝 Usage Examples

### Automatic Error Capture
```bash
# Failed command triggers automatic logging
npm install
# → Error logged to .learnings/ERRORS.md
# → Thai translation created
# → ClawMemory vector stored
```

### Manual Learning Entry
```markdown
## [LRN-20260302-001] correction

**Logged**: 2026-03-02T14:00:00+07:00
**Priority**: high
**Area**: backend

### Summary
Use environment variables for database config, not hardcoded values

### Details
Attempted to connect with hardcoded credentials...
```

### Promotion to Memory
```bash
# Promote important learning to permanent memory
python scripts/promote.py --id LRN-20260302-001 --target SOUL.md
```

## 🔄 Workflow Integration

### Daily Development
1. **Morning**: Review yesterday's learnings
2. **During Work**: Automatic error capture
3. **Evening**: Promote key insights
4. **Weekly**: Generate summary report

### Team Collaboration
- Shared learnings via Git
- ClawMemory sync across team
- Thai/English bilingual support
- Custom promotion rules

## 📈 Advanced Features

### Learning Scoring
AI-powered scoring system (1-10):
- **Accuracy**: Is the learning correct?
- **Efficiency**: Does it improve workflow?
- **Reusability**: How broadly applicable?
- **Clarity**: Is it well-documented?

### Smart Promotion
Automatic promotion when:
- Score ≥ 8/10
- Recurrence count ≥ 3
- Cross-area applicability
- Human approval obtained

### Graph Integration
```python
# Learning becomes part of knowledge graph
learning_node = clawmemory.create_node({
    "type": "learning",
    "content": "...",
    "relationships": ["javascript", "error-handling"]
})
```

## 🎛 Configuration

### Environment Variables
```bash
CLAWMEMORY_ENABLED=true
THAI_SUPPORT=true
SAFETY_MODE=strict
MAX_REFLECTIONS_PER_SESSION=5
PROMOTION_THRESHOLD=8
```

### Settings File
```yaml
# ~/.openclaw/skills/claw-selfimprove/config.yaml
auto_translate: true
safety_mode: "strict"
clawmemory_integration: true
thai_prompts: true
promotion_requires_approval: true
```

## 🚨 Safety & Privacy

- **Local-First**: All data stored locally
- **No External Calls**: No API dependencies
- **Privacy Filter**: Detects and flags sensitive data
- **Audit Trail**: Complete change history
- **Consent-Based**: Human approval for major changes

## 📚 Documentation

- [Full API Reference](docs/api.md)
- [Thai Language Guide](docs/thai-support.md)
- [ClawMemory Integration](docs/clawmemory.md)
- [Safety Configuration](docs/safety.md)
- [Troubleshooting](docs/troubleshooting.md)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Test with Thai language scenarios
4. Ensure safety compliance
5. Submit pull request

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Based on [self-improving-agent](https://github.com/peterskoett/self-improving-agent) by @pskoett - the most popular skill on ClawHub with 32K+ downloads and 338+ stars.

Enhanced for OpenKrab ecosystem with:
- ClawMemory vector integration
- Thai language support  
- Advanced safety features
- ClawFlow installation support

---

**Get Started**: `clawflow install claw-selfimprove`

**Support**: [GitHub Issues](https://github.com/openkrab/claw-selfimprove/issues)

**Community**: [OpenKrab Discord](https://discord.gg/openkrab)
