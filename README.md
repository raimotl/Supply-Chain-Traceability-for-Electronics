# Electronics Supply Chain Traceability

A blockchain-based solution for tracking electronics components and products throughout their lifecycle, from manufacturing to end-of-life.

## Overview

This project implements a supply chain traceability system for electronics using Clarity smart contracts on the Stacks blockchain. The system consists of four main contracts that work together to provide complete visibility into the lifecycle of electronic products:

1. **Component Registration Contract**: Tracks individual parts from manufacturers
2. **Assembly Verification Contract**: Records product construction and testing
3. **Distribution Tracking Contract**: Monitors movement through sales channels
4. **Warranty Management Contract**: Handles post-sale service and repairs

## Contracts

### Component Registration Contract

This contract allows manufacturers to register electronic components with detailed information:

- Manufacturer identity (blockchain address)
- Part number
- Description
- Manufacturing date
- Batch ID

Functions:
- `register-component`: Register a new component
- `get-component`: Retrieve component information
- `get-last-component-id`: Get the ID of the most recently registered component

### Assembly Verification Contract

This contract tracks the assembly of components into finished products:

- Assembler identity
- Product type
- Assembly date
- Serial number
- Test status
- List of component IDs used

Functions:
- `register-product`: Register a new assembled product
- `record-test`: Record test results for a product
- `get-product`: Retrieve product information
- `get-test`: Retrieve test information
- `get-last-product-id`: Get the ID of the most recently registered product

### Distribution Tracking Contract

This contract monitors the movement of products through the supply chain:

- Distribution events (shipping, receiving, etc.)
- Current product location
- Current product owner
- Transfer history

Functions:
- `record-distribution-event`: Record a new distribution event
- `transfer-ownership`: Transfer ownership of a product
- `get-product-status`: Get the current status of a product
- `get-distribution-event`: Retrieve distribution event information

### Warranty Management Contract

This contract handles warranty registration and service records:

- Warranty terms and duration
- Service history
- Warranty status (active/inactive)
- Parts replacement tracking

Functions:
- `register-warranty`: Register a warranty for a product
- `record-service`: Record a service event
- `void-warranty`: Void a warranty
- `get-warranty`: Retrieve warranty information
- `is-warranty-valid`: Check if a warranty is valid
- `get-service-record`: Retrieve service record information

## Testing

Tests are implemented using Vitest and cover:

- Individual contract functionality
- End-to-end supply chain flow
- Edge cases and error handling

To run the tests:

```bash
npm test
