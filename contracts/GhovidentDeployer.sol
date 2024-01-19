// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./GhovidentCompanyPool.sol";
import "./GhovidentPool.sol";
import "./interfaces/IGhovidentDeployer.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GhovidentDeployer is IGhovidentDeployer {
    struct CompanyParameters {
        address factory;
        string name;
        string email;
        string country;
        address company;
        string link;
        uint256 createdAt;
    }

    struct PoolParameters {
        address factory;
        string name;
        address assetes;
        RiskLevel risk;
        uint256 period;
        string link;
        address fundAddress;
    }

    CompanyParameters public override companyParameters;
    PoolParameters public override poolParameters;

    function deployCompanyPool(
        address factory,
        string memory name,
        string memory email,
        string memory country,
        address company,
        string memory link,
        uint256 createdAt
    ) internal returns (address companyPool) {
        companyParameters = CompanyParameters({
            factory: factory,
            name: name,
            email: email,
            country: country,
            company: company,
            link: link,
            createdAt: createdAt
        });
        companyPool = address(
            new GhovidentCompanyPool{
                salt: keccak256(abi.encode(name, company, createdAt))
            }()
        );
        delete companyParameters;
    }

    function deployPool(
        address _factory,
        string memory _name,
        address _assetes,
        RiskLevel _risk,
        uint256 _period,
        string memory _link,
        address _fundAddress
    ) internal returns (address pool) {
        poolParameters = PoolParameters({
            factory: _factory,
            name: _name,
            assetes: _assetes,
            risk: _risk,
            period: _period,
            link: _link,
            fundAddress: _fundAddress
        });
        pool = address(
            new GhovidentPool{
                salt: keccak256(abi.encode(_name, _assetes, _risk))
            }()
        );
        delete poolParameters;
    }
}
