// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

/*  QUESTIONS AND ANSWERS

    1. 📕 Describe the four visibility keywords and their impact on the code.
    ANS:    The four visibility keywords of public, internal, private and external determine whether a 
            state variable or function can be read or modified by other contracts.

            For public state variables the compiler automatically generates getter functions for them, 
            which allows other contracts to read their values. For functions, they become callable by other contracts.

            Internal state variables can only be accessed from within the contract they are defined 
            in and in derived contracts. They cannot be accessed externally. This is the default visibility 
            level for state variables.

            Private state variables are like internal ones but they are not visible in derived contracts.

            External functions are part of the contract interface, which means they can be called from other 
            contracts and via transactions. An external function f cannot be called internally 
            (i.e. f() does not work, but this.f() works).

            It is worthy of note that making something private or internal only prevents other contracts from reading 
            or modifying the information, but it will still be visible to the whole world outside of the blockchain.

    2. 📕 What's the difference between `view` and `pure`?
    3. 📕 In which circumstances a `pure` function will incur gas costs?
    4. 📕 Explain what a _scope_ is and provide an example of an incorrect scope.
    5. 📕 What's the difference between a transaction that deploys a contract and a transaction that transfers ETH?
    6. 🧑‍💻 Write a contract that features 3 functions:
        - a view function that can be accessed only by the current contract
        - a pure function that's not accessible within the current contract
        - a view function that can be accessed from children's contracts
*/

// 6. A contract that features 3 functions:
contract SimpleStorageFunctions {
    string name = "ChainKing";

    // a view function that can be accessed only by the current contract
    function viewName() private view returns (string memory) {
        return name;
    }

    // a pure function that's not accessible within the current contract
    function getValue() external pure returns (uint256) {
        return 1;
    }

    // a view function that can be accessed from children's contracts
    function getName() internal view returns (string memory) {
        return name;
    }
}
