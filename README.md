# 🥖 My AL Project - Business Central Extension

[![AL Language](https://img.shields.io/badge/AL-Business%20Central-blue)](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-programming-in-al)
[![Business Central](https://img.shields.io/badge/Business%20Central-22.0-green)](https://docs.microsoft.com/en-us/dynamics365/business-central/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A comprehensive Business Central extension demonstrating best practices for AL development, featuring robust error handling, data validation, and enterprise-grade code structure.

## 📋 **Features**

- ✅ **Custom Table** with comprehensive validation
- ✅ **Card Page** with enhanced user experience
- ✅ **Business Logic Codeunit** with error handling
- ✅ **Custom Report** with filtering capabilities
- ✅ **Enum Status Management** 
- ✅ **Permission Set** for security
- ✅ **Complete Documentation** and best practices

## 🏗️ **Project Structure**

```
my-al-project/
├── 📁 .vscode/              # VS Code configuration
│   └── launch.json          # Deployment settings
├── 📁 src/                  # AL source code
│   ├── 📁 tables/           # Table objects
│   ├── 📁 pages/            # Page objects
│   ├── 📁 reports/          # Report objects
│   ├── 📁 codeunits/        # Business logic
│   ├── 📁 enums/            # Enumerations
│   └── 📁 permissions/      # Permission sets
├── 📁 docs/                 # Documentation
│   ├── BEST_PRACTICES.md    # Development guidelines
│   └── ERROR_HANDLING_GUIDE.md
├── app.json                 # Extension manifest
├── ruleset.json            # Code quality rules
└── README.md               # This file
```

## Components

### Codeunits
- **MyCodeunit.Codeunit.al**: Contains methods that implement business logic and can be called from other objects.

### Pages
- **MyPage.Page.al**: Defines the layout and data source for user interaction with the data.

### Tables
- **MyTable.Table.al**: Specifies the fields and data types for storing data in the database.

### Reports
- **MyReport.Report.al**: Defines the layout and data source for generating reports based on application data.

## Setup Instructions
1. Clone the repository to your local machine.
2. Open the project in your development environment.
3. Ensure that all dependencies are installed.
4. Configure the `app.json` file with your application details.
5. Use the `launch.json` file to set up your debugging environment.

## Usage Guidelines
- Use the codeunits to implement and call business logic.
- Access the pages for user interaction with the data.
- Utilize the tables for data storage and management.
- Generate reports using the defined report layouts.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.