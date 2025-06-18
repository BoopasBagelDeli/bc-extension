# 🚀 **GitHub Repository Setup Guide**

This guide will help you set up your AL project as a GitHub repository with best practices.

## 📋 **Prerequisites**

### **Install Required Tools**
1. **Git for Windows**: [Download here](https://git-scm.com/download/win)
2. **GitHub Desktop** (optional): [Download here](https://desktop.github.com/)
3. **VS Code** with Git integration enabled

## 🔧 **Step-by-Step Setup**

### **Step 1: Install Git**
```bash
# Download and install Git for Windows
# Or use chocolatey:
choco install git

# Or use winget:
winget install Git.Git
```

### **Step 2: Configure Git**
```bash
# Set your name and email
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Set line ending preferences for Windows
git config --global core.autocrlf true
```

### **Step 3: Initialize Repository**
```bash
# Navigate to your project directory
cd "c:\Users\Nic\my-al-project"

# Initialize git repository
git init

# Add all files to staging
git add .

# Create initial commit
git commit -m "Initial commit: AL Business Central extension"
```

### **Step 4: Create GitHub Repository**

#### **Option A: Using GitHub Web Interface**
1. Go to [GitHub.com](https://github.com)
2. Click "New repository"
3. Name: `my-al-project`
4. Description: `Business Central AL extension with best practices`
5. Choose Public or Private
6. **Don't** initialize with README (we already have one)
7. Click "Create repository"

#### **Option B: Using GitHub CLI**
```bash
# Install GitHub CLI first
winget install GitHub.cli

# Authenticate
gh auth login

# Create repository
gh repo create my-al-project --public --description "Business Central AL extension"
```

### **Step 5: Connect Local to GitHub**
```bash
# Add GitHub as remote origin
git remote add origin https://github.com/yourusername/my-al-project.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## 📁 **Repository Structure Created**

Your repository now includes:

```text
my-al-project/
├── 📁 .github/
│   └── 📁 workflows/
│       ├── ci.yml           # Continuous Integration
│       └── release.yml      # Release automation
├── 📁 .vscode/
│   └── launch.json
├── 📁 docs/
│   ├── BEST_PRACTICES.md
│   └── ERROR_HANDLING_GUIDE.md
├── 📁 src/
│   ├── 📁 codeunits/
│   ├── 📁 enums/
│   ├── 📁 pages/
│   ├── 📁 permissions/
│   ├── 📁 reports/
│   └── 📁 tables/
├── .gitignore              # Git ignore rules
├── app.json               # Extension manifest
├── CONTRIBUTING.md        # Contribution guidelines
├── LICENSE               # MIT License
├── README.md            # Project documentation
└── ruleset.json        # Code quality rules
```

## 🔄 **Git Workflow Best Practices**

### **Branch Strategy**
```bash
# Create feature branch
git checkout -b feature/new-validation-rules

# Make changes, then commit
git add .
git commit -m "feat: add customer name validation"

# Push feature branch
git push origin feature/new-validation-rules

# Create Pull Request on GitHub
# After review and merge, delete feature branch
git checkout main
git pull origin main
git branch -d feature/new-validation-rules
```

### **Commit Message Conventions**
```bash
# Feature additions
git commit -m "feat: add new table for customer data"

# Bug fixes  
git commit -m "fix: resolve validation error in name field"

# Documentation
git commit -m "docs: update deployment instructions"

# Code formatting
git commit -m "style: fix indentation in codeunit"

# Refactoring
git commit -m "refactor: simplify error handling logic"
```

## 🏷️ **Release Management**

### **Creating Releases**
```bash
# Tag a release
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push tags
git push origin --tags

# GitHub Actions will automatically create release
```

### **Semantic Versioning**
- `v1.0.0` - Major release (breaking changes)
- `v1.1.0` - Minor release (new features)
- `v1.0.1` - Patch release (bug fixes)

## 🔒 **Security Best Practices**

### **Sensitive Data Protection**
```bash
# Never commit these files:
*.secret
.env
appsettings.*.json
launch.json.backup

# Use .gitignore to exclude sensitive files
```

### **Repository Settings**
1. Enable branch protection for `main`
2. Require pull request reviews
3. Enable status checks
4. Enable automatic security updates

## 📊 **GitHub Features Setup**

### **Issues Template**
Create `.github/ISSUE_TEMPLATE/bug_report.md`:
```markdown
---
name: Bug report
about: Create a report to help us improve
title: ''
labels: bug
assignees: ''
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior

**Expected behavior**
A clear and concise description of what you expected to happen.

**Business Central Environment**
- Version: [e.g. 22.0]
- Environment: [e.g. Sandbox]
```

### **GitHub Pages Documentation**
1. Go to Repository Settings
2. Enable GitHub Pages
3. Source: `Deploy from a branch`
4. Branch: `main`, folder: `/docs`

## 🤝 **Team Collaboration**

### **Adding Collaborators**
1. Repository Settings → Manage access
2. Invite collaborators
3. Set appropriate permissions

### **Code Review Process**
1. Create feature branch
2. Make changes
3. Create Pull Request
4. Request reviews
5. Address feedback
6. Merge when approved

## 📈 **Monitoring and Analytics**

### **GitHub Insights**
- Track commit activity
- Monitor pull requests
- Review contributor statistics
- Analyze code frequency

## 🎯 **Next Steps**

1. **Install Git** if not already installed
2. **Configure Git** with your credentials
3. **Create GitHub repository**
4. **Push your code**
5. **Set up branch protection**
6. **Invite collaborators**
7. **Start using GitHub workflow**

## 📞 **Support**

If you need help:
- [GitHub Documentation](https://docs.github.com/)
- [Git Documentation](https://git-scm.com/doc)
- [AL Development Guide](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/)

---

**Your AL project is now ready for professional GitHub collaboration! 🎉**
