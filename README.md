# CookMate 🍳
> A voice-controlled recipe assistant mobile app — hands-free cooking, powered by Flutter & Django.

## Features
- 🎙️ Voice commands — navigate recipes hands-free
- 🔊 Text-to-speech — app reads each cooking step aloud
- ⏱️ Smart timers — voice-triggered with spoken alerts
- 🌐 Offline-first — browse recipes without internet
- 🔐 JWT Authentication — secure user accounts

## Tech Stack
**Mobile:** Flutter 3.44.0, Dart, flutter_bloc, go_router, Clean Architecture  
**Backend:** Django, Django REST Framework, PostgreSQL  
**Voice:** flutter_tts, speech_to_text, custom intent parser  
**DevOps:** GitHub Actions CI, Render deployment

## Architecture
Clean Architecture with 3 layers per feature:
- `presentation/` — Screens, Widgets, Bloc
- `domain/` — Entities, Use Cases, Repository interfaces
- `data/` — API, local cache (Hive), models

## Project Status
🚧 In active development

## Author
Sangavan — IT Undergraduate, Rajarata University of Sri Lanka