// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentDeployer.sol";

contract GhovidentFactory is GhovidentDeployer {
    // Events
    event PoolCreated(address pool);
    event CompanyCreated(address company);

    // State variables
    address[] public pools;
    address[] public companies;

    // Functions
    function createCompany(
        string memory name,
        string memory email,
        string memory country,
        string memory link
    ) external returns (address companyPool) {
        companyPool = deployCompanyPool(
            address(this),
            name,
            email,
            country,
            msg.sender,
            link,
            block.timestamp
        );
        pools.push(companyPool);
        emit CompanyCreated(companyPool);
    }

    function createPool(
        string memory _name,
        address _assetes,
        RiskLevel _risk,
        uint256 _period,
        string memory _link,
        address _fundAddress
    ) external returns (address pool) {
        pool = deployPool(
            address(this),
            _name,
            _assetes,
            _risk,
            _period,
            _link,
            _fundAddress
        );
        emit PoolCreated(pool);
    }
}
