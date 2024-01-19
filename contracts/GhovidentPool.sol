// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentDeployer.sol";
import "./interfaces/IGhovidentPool.sol";
import "./interfaces/IGhovidentInvestment.sol";
import "./interfaces/IGhovidentDeployer.sol";

contract GhovidentPool is IGhovidentPool {
    address public factory;
    string public name;
    address public assetes;
    IGhovidentDeployer.RiskLevel public risk;
    uint256 public period;
    string public link;
    address public fundAddress;

    IGhovidentInvestment private _fundAddress;

    constructor() {
        (
            factory,
            name,
            assetes,
            risk,
            period,
            link,
            fundAddress
        ) = IGhovidentDeployer(msg.sender).poolParameters();
        _fundAddress = IGhovidentInvestment(fundAddress);
    }

    function stake(uint _amout) external override {
        _fundAddress.stake(_amout);
    }

    function loan() external override {
        _fundAddress.loan();
    }

    function getPoolInfo()
        external
        view
        override
        returns (
            string memory,
            address,
            IGhovidentDeployer.RiskLevel,
            uint256,
            string memory,
            address
        )
    {
        return (name, assetes, risk, period, link, fundAddress);
    }
}
