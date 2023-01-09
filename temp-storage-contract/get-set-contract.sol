// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;

contract SimpleStorage {
    string favNumberInTxt = "onetwentythree";
    uint256 faveNumber;

    struct People {
        uint256 favPNumber;
        string name;
    }

    People public peeps = People({favPNumber: 60, name: "sameljackson"});

    People[] public folks;

    mapping(string => uint256) public nameToFaveNumber;

    function store(uint256 _input_num) public {
        faveNumber = _input_num;
        retrive();
    }

    function retrive() public view returns (uint256) {
        return faveNumber;
    }

    function addPersion(uint256 number, string memory name) public {
        folks.push(People(number, name));
        nameToFaveNumber[name] = number;
    }

    // 0xd9145CCE52D386f254917e481eB44e9943F39138
}
