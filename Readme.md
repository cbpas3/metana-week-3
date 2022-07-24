# ERC721Pausable and ERC721Storage

## Pausable

### Added Functionalities:

Can pause minting, burning and transactions

### Risks:

Implementor might forget to make the pause and unpause functions useable by the admin only

Implementor might use Ownable for access control of the _pause and _unpause functions, if they renounceownership while it is paused then it can never be unpaused

## Storage

### Added Functionalities:

Can store the token URIs within the contract

Each URI is connected by a map to each token ID

### Pros

You’re sure that the link won’t go down without the contract

### Cons

More expensive

# ERC 721 vs ERC 1155 

ERC721 is the standard interface for non-fungible tokens. ERC1155 is the standard interface that can have both non-fungible tokens and fungible tokens. The ERC1155 standard is able to support both fungible and non-fungible tokens by having the token ID represent the token type as well. 

The single transfer function of the ERC1155 token, while having similar steps with the ERC721 transfer function, is different with how they check if the sender has enough tokens that the transaction needs since in the ERC1155 standard the tokens that are being transferred can possibly be fungible tokens. Additionally, ERC1155 has a built-in batch transfer function.