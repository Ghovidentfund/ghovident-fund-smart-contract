// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./IGhovidentDeployer.sol";

interface IGhovidentPool {
    // Enums

    // Event
    // State variables
    // function factory() external view returns (address);

    // function name() external view returns (string memory);

    // function assetes() external view returns (address);

    // function risk() external view returns (RiskLevel);

    // function period() external view returns (uint256);

    // function link() external view returns (string memory);

    // function fundAddress() external view returns (address);

    // Write functions
    function stake(uint _amout) external;

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
            address
        );
}
