# Transportation GenAI Solutions

## Overview
This project targets the transportation sector, specifically addressing the unique challenges faced by informal "radio taxi" networks in Los Angeles. These networks primarily consist of Spanish-speaking drivers who operate on a subscription model ("membership fee") rather than a commission-based app model.

## The Challenge
**Communication Barrier**: A significant friction point exists between Spanish-speaking drivers and non-Spanish-speaking passengers.
- **Current State**: Drivers often communicate via PTT (Push-to-Talk) apps like Zello or WhatsApp voice notes. Dispatchers handle the initial connection, but in-car communication remains difficult.
- **Need**: A real-time, low-latency, bi-directional audio translation system that allows drivers and passengers to speak naturally in their native languages.

## Proposed Solution: "GenAI Babel Bridge"
A cost-efficient, scalable AWS Serverless solution to convert audio streams in real-time.

### Architecture Highlights
- **Input**: Audio Stream from Mobile App (Driver/Passenger).
- **Core Services**:
    - **Amazon Transcribe Streaming**: Converts speech to text on the fly.
    - **Amazon Translate**: Translates text between Spanish and English (and other languages) with low latency.
    - **Amazon Polly**: Synthesizes natural-sounding speech from the translated text.
- **Compute**: AWS Lambda (Serverless) to orchestrate the pipeline, ensuring costs are incurred only during processing.
- **Transport**: AWS API Gateway (WebSockets) for real-time bi-directional communication.

## Project Structure
- `code/`: Contains the reference architecture and prototype code.
    - [Architecture Diagram](code/architecture.mermaid)
    - [Translation Service Prototype](code/translation_service.py)
- [WIKI.md](WIKI.md): Detailed analysis of the LA Driver Business Model and technical deep dive.

## Installation & Setup
1. **Prerequisites**: AWS Account, Python 3.9+, AWS CLI configured.
2. **Deploy**: Use the provided scripts (coming soon) to deploy the Lambda functions and API Gateway.

## TODO & Audit
- [x] Research LA Spanish Driver business model (Completed).
- [x] Design AWS GenAI Audio Translation Architecture (Completed).
- [ ] Implement VAD (Voice Activity Detection) to further optimize costs.
- [ ] Develop mobile client SDKs (iOS/Android) for handling the WebSocket audio stream.

