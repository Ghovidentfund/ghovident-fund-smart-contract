// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentPool.sol";
import "./interfaces/IGhovidentDeployer.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GhovidentDeployer is IGhovidentDeployer {
    struct Parameters {
        address factory;
        string name;
        string email;
        string country;
        address company;
        string link;
        uint256 createdAt;
    }

    Parameters public override parameters;

    function deploy(
        address factory,
        string memory name,
        string memory email,
        string memory country,
        address company,
        string memory link,
        uint256 createdAt
    ) internal returns (address pool) {
        parameters = Parameters({
            factory: factory,
            name: name,
            email: email,
            country: country,
            company: company,
            link: link,
            createdAt: createdAt
        });
        pool = address(
            new GhovidentPool{
                salt: keccak256(abi.encode(name, company, createdAt))
            }()
        );
        delete parameters;
    }
}
