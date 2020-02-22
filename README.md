#
GLPI Active Scanner

GLPIScan is a scanner to find vulnerabilities into glpi platforms. GLPI is usually used internally, almost never you'll find opened to the internet ( but is possible ).

## What's GLPI ?

GLPI is an incredible ITSM software tool that helps you plan and manage IT changes in an easy way, solve problems efficiently when they emerge and allow you to gain legitimate control over your company’s IT budget, and expenses.

## What does the glpi-checker check?

1. Misconfiguration
2. User Enumeration
3. SQL dumps ( it's possible to clone the target) TODO!
4. Default credentials TODO!
5. Vulnerable versions
6. System information as OS and Web Server


## how to install

```bash
git clone https://github.com/Kitsun3Sec/glpiscan.git
cd glpiscan
bundle install
```

## Usage

```bash
./glpiscan.rb TARGET 
```
