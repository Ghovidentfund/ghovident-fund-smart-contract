// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GhovidentPool {
    // Pool state
    address public immutable factory;
    string public name; // pool name
    uint256 public totalInvestment;

    struct Company {
        // uint companyId;
        string name;
        address companyAddress;
        uint256 totalInvestment;
        uint256 totalEmployee;
        Employee[] employees;
    }

    struct Employee {
        // uint companyId;
        // uint employeeId;
        string name;
        address employeeAddress;
        // uint256 salary;
        uint256 joinDate;
        // uint256 contribution;
        uint256 totalPay;
    }

    // uint public emplaoyeeId = 0;
    // uint public companyId = 0;
    mapping(address => Company) public allCompanies;
    mapping(address => Employee) public allEmployees;

    constructor(address _factory, string memory _name) {
        factory = _factory;
        name = _name;
    }

    // https://stackoverflow.com/questions/72573064/push-data-into-a-nested-struct-array
    // create function to add company and employee
    function registerCompany(
        string memory _name,
        string[] calldata _employeeNames,
        address[] calldata _employeeAddresses,
        // uint256[] calldata _employeeSalaries,
        uint256[] calldata _employeeJoinDates,
        // uint256[] calldata _employeeContributions
        uint256[] calldata _employeeTotalPays
    ) external {
        // if (companyId != 0) {
        //     companyId++;
        // }
        Company storage company = allCompanies[msg.sender];
        // company.companyId = companyId;
        company.name = _name;
        company.companyAddress = msg.sender;
        company.totalInvestment = 0;
        company.totalEmployee = 0;

        for (uint i = 0; i < _employeeNames.length; i++) {
            // if (emplaoyeeId != 0) {
            //     emplaoyeeId++;
            // }
            Employee storage employee = allEmployees[_employeeAddresses[i]];
            // employee.companyId = companyId;
            // employee.employeeId = emplaoyeeId;
            employee.name = _employeeNames[i];
            employee.employeeAddress = _employeeAddresses[i];
            // employee.salary = _employeeSalaries[i];
            employee.joinDate = _employeeJoinDates[i];
            // employee.contribution = _employeeContributions[i];
            employee.totalPay = _employeeTotalPays[i];
            company.totalEmployee++;
            company.employees.push(employee);
            totalInvestment += _employeeTotalPays[i];
        }

        allCompanies[msg.sender] = company;
    }

    //

    // setters
    function setName(string memory _name) external {
        name = _name;
    }

    // getters
    function getName() external view returns (string memory) {
        return name;
    }

    function getCompany(
        address _companyAddress
    ) external view returns (Company memory) {
        return allCompanies[_companyAddress];
    }
}
