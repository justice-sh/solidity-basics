// SPDX-License-Identifier: MIT
pragma solidity 0.8.30; // solidity version 

contract SimpleStorage {

    uint256 favoriteNumber = 5;

    struct Person {
        uint256 favoriteNumber; // Note: faviouriteNumber here doesn't clash with the one outside;
        string name;
    }

    // Person pat = Person(1, "Pata");
    Person public pat = Person({favoriteNumber: 6, name: "Pat"});

    Person[] public people;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory name, uint256 _favoriteNumber) public {
        Person memory person = Person(_favoriteNumber, name);
        people.push(person);
        nameToFavoriteNumber[name] = _favoriteNumber;
    }
}