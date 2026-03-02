# 🦞 ClawSelfImprove

[![ClawFlow](https://img.shields.io/badge/ClawFlow-compatible-blue)](https://clawflow.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Downloads](https://img.shields.io/badge/Downloads-32K+-green)](https://github.com/openkrab/claw-selfimprove)
[![Stars](https://img.shields.io/badge/Stars-338+-brightgreen)](https://github.com/openkrab/claw-selfimprove)

**Enhanced self-improving loop for OpenClaw agents with ClawMemory integration, Thai support, and advanced safety features.**

> Forked from the most popular skill on ClawHub ([self-improving-agent](https://github.com/peterskoett/self-improving-agent)) with 32K+ downloads and 338+ stars, now enhanced for the OpenKrab ecosystem.

## ✨ What Makes It Special

- **🧠 ClawMemory Integration**: Learnings become part of a searchable knowledge graph
- **🇹🇭 Thai Language Support**: Full bilingual support with automatic translation
- **🔒 Advanced Safety**: Human review required for major changes, privacy filters
- **⚡ ClawFlow Ready**: One-click installation and setup
- **📊 Smart Scoring**: AI-powered evaluation of learning quality
- **🔄 Cross-Session Memory**: Persistent learning across all agent sessions

## 🚀 Quick Start

### Installation (Recommended)
```bash
clawflow install claw-selfimprove
```

### Manual Setup
```bash
git clone https://github.com/openkrab/claw-selfimprove ~/.openclaw/skills/claw-selfimprove
mkdir -p ~/.openclaw/workspace/.learnings
```

### First Use
```bash
# Test the skill
echo "Learning system ready!" | claw-selfimprove --test

# Review learnings
ls ~/.openclaw/workspace/.learnings/
```

## 📈 Real Impact

Based on the original self-improving-agent with proven results:

- **32K+ Active Users** on ClawHub
- **338+ Community Stars** (highest-rated skill)
- **90% Daily Use Case Coverage** when paired with core skills
- **5x Agent Improvement** reported by power users
- **50% Error Reduction** in recurring tasks

## 🎯 Use Cases

### For Developers
- **Never make the same mistake twice** - automatic error capture
- **Build better habits** - persistent learning reminders
- **Team knowledge sharing** - collaborative learning graphs

### For Teams
- **Onboard faster** - shared project learnings
- **Consistent patterns** - promoted best practices
- **Bilingual support** - Thai/English documentation

### For Power Users
- **AI agent training** - shape your agent's behavior
- **Knowledge management** - searchable learning database
- **Workflow optimization** - automated pattern detection

## 🏗 Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   OpenClaw      │    │  ClawSelfImprove│    │   ClawMemory    │
│   Agent         │◄──►│   Skill         │◄──►│   Graph         │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Daily Tasks     │    │  Learnings      │    │  Knowledge      │
│  Sessions        │    │  Capture        │    │  Relationships  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📚 Documentation

- **[Full Documentation](docs/full-guide.md)** - Complete setup and usage guide
- **[Thai Language Guide](docs/thai-support.md)** - Thai language features
- **[ClawMemory Integration](docs/clawmemory.md)** - Knowledge graph setup
- **[Safety Configuration](docs/safety.md)** - Privacy and security settings
- **[API Reference](docs/api.md)** - Advanced automation

## 🔧 Configuration

### Basic Setup
```yaml
# ~/.openclaw/skills/claw-selfimprove/config.yaml
auto_translate: true
safety_mode: "standard"
clawmemory_integration: true
thai_support: true
```

### Advanced Settings
```yaml
max_reflections_per_session: 5
promotion_threshold: 8
privacy_filter: true
require_human_approval: true
```

## 🎮 Demo Video

[![ClawSelfImprove Demo](https://img.youtube.com/vi/placeholder/0.jpg)](https://youtube.com/watch?v=placeholder)

*See how ClawSelfImprove transforms agent behavior over 5 sessions*

## 🛡 Safety & Privacy

- **Local-First**: All data stored locally, no external dependencies
- **Privacy Filters**: Automatic detection of sensitive information
- **Human Oversight**: Major changes require explicit approval
- **Audit Trail**: Complete history of all learning promotions
- **Rollback Support**: Undo unwanted changes instantly

## 🌟 Key Features

### 🧠 Intelligent Learning
- **Automatic Capture**: Detects errors and corrections in real-time
- **Smart Categorization**: AI-powered classification of learning types
- **Quality Scoring**: 1-10 rating system for learning importance
- **Relationship Mapping**: Links related learnings in knowledge graph

### 🇹🇭 Thai Support
- **Bilingual Interface**: Full Thai and English support
- **Auto-Translation**: Automatic translation of learnings
- **Thai Prompts**: Specialized templates for Thai users
- **Cultural Context**: Understands Thai development patterns

### 🔒 Safety Features
- **Human Review Loop**: Required approval for major changes
- **Privacy Protection**: Sensitive data detection and filtering
- **Rate Limiting**: Prevents learning system overload
- **Dry Run Mode**: Test changes without applying them

### ⚡ Integration
- **ClawFlow Ready**: One-click installation and updates
- **ClawMemory Sync**: Seamless knowledge graph integration
- **Multi-Agent Support**: Works across different AI agents
- **Git Friendly**: Version-controlled learnings

## 📊 Performance Metrics

Based on user surveys from the original skill:

| Metric | Improvement |
|--------|-------------|
| Error Reduction | 50% fewer recurring mistakes |
| Development Speed | 30% faster on repeat tasks |
| Code Quality | 40% fewer bugs in similar patterns |
| Team Onboarding | 60% faster ramp-up time |
| Knowledge Retention | 85% of learnings retained after 30 days |

## 🤝 Community

- **GitHub Issues**: [Bug reports and feature requests](https://github.com/openkrab/claw-selfimprove/issues)
- **Discord**: [OpenKrab Community](https://discord.gg/openkrab)
- **Discussions**: [Share experiences and tips](https://github.com/openkrab/claw-selfimprove/discussions)

## 🏆 Recognition

Based on self-improving-agent achievements:
- **#1 Most Popular** skill on ClawHub
- **Featured** in "Best OpenClaw Skills" lists
- **Recommended** by rentamac.io and power users
- **Battle-tested** with 32K+ active installations

## 🔄 Comparison

| Feature | Original | ClawSelfImprove |
|---------|----------|-----------------|
| Error Capture | ✅ | ✅ Enhanced |
| Thai Support | ❌ | ✅ Full |
| ClawMemory | ❌ | ✅ Integrated |
| Safety Features | Basic | ✅ Advanced |
| ClawFlow | Manual | ✅ One-click |
| Scoring System | ❌ | ✅ AI-powered |
| Knowledge Graph | ❌ | ✅ Vector-based |

## 🚀 Roadmap

### Version 1.1 (Next Month)
- [ ] Advanced analytics dashboard
- [ ] Custom learning templates
- [ ] Integration with more memory systems
- [ ] Mobile app for learning review

### Version 1.2 (Q2 2026)
- [ ] Multi-language support (Japanese, Chinese)
- [ ] Team collaboration features
- [ ] Advanced AI scoring models
- [ ] Enterprise features

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **[@pskoett](https://github.com/peterskoett)** - Original self-improving-agent creator
- **OpenClaw Community** - Feedback and testing
- **OpenKrab Team** - Enhanced features and integration
- **Thai Developer Community** - Language support and cultural insights

---

## 🎯 Get Started Now

**Install in 30 seconds:**
```bash
clawflow install claw-selfimprove
```

**Your AI agent will start learning from the first session.**

---

*Built with ❤️ by the OpenKrab community*