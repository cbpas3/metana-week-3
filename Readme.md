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