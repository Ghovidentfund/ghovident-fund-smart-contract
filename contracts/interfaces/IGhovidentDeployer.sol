// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IGhovidentDeployer {
    // Enums
    enum RiskLevel {
        Low,
        Moderate,
        High,
        VeryHigh
    }

    function companyParameters()
        external
        view
        returns (
            address factory,
            string memory name,
            string memory email,
            string memory country,
            address company,
            string memory link,
            uint256 createdAt
        );

    function poolParameters()
        external
        view
        returns (
            address factory,
            string memory name,
            address assetes,
            RiskLevel risk,
            uint256 period,
            string memory link,
            address fundAddress
        );
}
