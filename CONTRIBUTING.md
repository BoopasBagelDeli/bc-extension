# Contributing to My AL Project

Thank you for your interest in contributing to this Business Central AL extension! 

## 🚀 **Getting Started**

### **Prerequisites**
- Visual Studio Code
- AL Language Extension
- Business Central development environment
- Git knowledge

### **Development Setup**
1. Fork the repository
2. Clone your fork locally
3. Open in VS Code
4. Configure your development environment
5. Make your changes
6. Test thoroughly

## 📋 **Development Guidelines**

### **Code Standards**
- Follow AL language best practices
- Use meaningful variable and function names
- Include comprehensive error handling
- Add appropriate documentation
- Maintain consistent code formatting

### **Naming Conventions**
```al
// Tables
table 50XXX "My Table Name"

// Pages  
page 50XXX "My Page Name"

// Codeunits
codeunit 50XXX "My Codeunit Name"

// Variables
MyVariableName: Text[100];
```

### **Error Handling**
Always implement proper error handling:
```al
[TryFunction]
local procedure TryDoSomething(): Boolean
begin
    // Implementation
end;

if not TryDoSomething() then begin
    ErrorInfo.Message := 'Operation failed';
    Error(ErrorInfo);
end;
```

## 🔄 **Pull Request Process**

### **Before Submitting**
1. Ensure all tests pass
2. Update documentation if needed
3. Follow commit message conventions
4. Rebase on latest main branch

### **PR Requirements**
- [ ] Code compiles without errors
- [ ] All validation rules tested
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)
- [ ] Performance impact considered

### **Commit Messages**
Use conventional commit format:
```
feat: add new validation rule for customer names
fix: resolve issue with date calculation
docs: update deployment instructions
style: fix code formatting
refactor: simplify error handling logic
```

## 🧪 **Testing**

### **Required Tests**
- Compile and deployment test
- Field validation testing
- Business logic verification
- Error handling validation
- User interface testing

### **Test Checklist**
- [ ] All objects compile successfully
- [ ] No permission errors
- [ ] Validation rules work correctly
- [ ] Error messages are user-friendly
- [ ] Performance is acceptable

## 📚 **Documentation**

### **Required Documentation**
- Code comments for complex logic
- Update README.md if needed
- Add to best practices guide
- Update deployment instructions

### **Documentation Standards**
```al
/// <summary>
/// Brief description of the procedure/function
/// </summary>
/// <param name="ParameterName">Description of parameter</param>
/// <returns>Description of return value</returns>
procedure MyProcedure(ParameterName: Text): Boolean
```

## 🏷️ **Issue Reporting**

### **Bug Reports**
Include:
- Business Central version
- AL extension version
- Steps to reproduce
- Expected vs actual behavior
- Error messages
- Screenshots if helpful

### **Feature Requests**
Include:
- Business justification
- Proposed implementation
- Impact assessment
- Alternatives considered

## 🔒 **Security**

### **Security Guidelines**
- Never commit sensitive data
- Use proper data classification
- Implement appropriate permissions
- Follow security best practices
- Report security issues privately

## 📞 **Getting Help**

- Check existing issues and documentation
- Join community discussions
- Ask questions in pull requests
- Contact maintainers for complex issues

## 🙏 **Recognition**

Contributors will be recognized in:
- Repository contributors list
- Release notes
- Documentation acknowledgments

Thank you for helping make this project better! 🎉
