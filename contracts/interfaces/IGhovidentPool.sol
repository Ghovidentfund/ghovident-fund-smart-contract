// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./IGhovidentDeployer.sol";

interface IGhovidentPool {
    // Write functions
    function stake(uint256 amount) external;

    function loan() external;

    // Read functions
    function getPoolInfo()
        external
        view
        returns (
            string memory,
            address,
            IGhovidentDeployer.RiskLevel,
            uint256,
            string memory,
            address,
            bool
        );

    function setPoolStatus(bool _status) external;
}
