Here is the full and updated `README.md` content — ready to copy into your repo — including:

- ✅ Project Overview  
- ✅ Features  
- ✅ Tech Stack  
- ✅ Flutter BLoC Architecture  
- ✅ Node.js Express Architecture  
- ✅ Setup Instructions  
- ✅ API Routes  
- ✅ MVP Goals  
- ✅ License  

---

### 📄 `README.md` (Complete Markdown Content)

```markdown
# 🎥 YouTube Transcript & Summary Generator

A web app that allows users to input a YouTube video URL and get a full transcript and an AI-generated summary using OpenAI Whisper and GPT APIs.

---

## ✨ Features

- 🔗 Accepts public YouTube video URL
- 📄 Transcribes audio using OpenAI Whisper
- 🧠 Summarizes video using GPT-4
- 🌐 Flutter Web frontend
- ⚙️ Node.js backend
- 🗂 Optional PostgreSQL integration
- 🐳 Docker-ready for local development

---

## 🛠 Tech Stack

| Layer         | Technology              |
|---------------|--------------------------|
| Frontend      | Flutter Web + BLoC       |
| Backend       | Node.js (Express)        |
| AI Services   | OpenAI Whisper, GPT-4    |
| Database      | PostgreSQL (Optional)    |
| Deployment    | Docker (Optional)        |

---

## 🏗 Architecture Overview

```
Flutter UI
   ↓
BLoC (Business Logic)
   ↓
Repository → REST API
   ↓
Node.js Express Server
   ↓
OpenAI APIs (Whisper, GPT-4)
   ↓
PostgreSQL (Optional)
```

---

## 🧱 Flutter BLoC Architecture

```
lib/
├── blocs/            # Business Logic Components (BLoC)
│   ├── transcript/
│   │   ├── transcript_bloc.dart
│   │   ├── transcript_event.dart
│   │   └── transcript_state.dart
│   └── summary/
│       └── ...
├── models/           # Data models (Transcript, Summary)
├── repositories/     # Abstracted API logic
├── screens/          # UI views (input, result, error)
├── widgets/          # Reusable UI elements
├── main.dart         # Entry point
```

> Uses `flutter_bloc`, `dio` for networking, and adheres to separation of concerns.

---

## 🛠 Node.js Express Architecture

```
backend/
├── controllers/          # Request handling logic
│   ├── transcript.controller.js
│   └── summary.controller.js
├── routes/               # Route definitions
│   ├── transcript.routes.js
│   └── summary.routes.js
├── services/             # Whisper/GPT integration
├── utils/                # Helpers and validators
├── middlewares/          # Error handling, logging
├── index.js              # App entry point
├── .env.example          # Env configuration sample
```

> Includes OpenAI SDK, YouTube parsing (`ytdl-core`), and dotenv for env variables.

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/yt-summarizer.git
cd yt-summarizer
```

---

### 2. Backend Setup (Node.js)

```bash
cd backend
cp .env.example .env
npm install
npm run dev
```

Set your `OPENAI_API_KEY` in the `.env` file.

---

### 3. Frontend Setup (Flutter)

```bash
cd frontend
flutter pub get
flutter run -d chrome
```

---

## 📮 API Routes

| Method | Endpoint        | Description                        |
|--------|------------------|------------------------------------|
| POST   | `/transcribe`    | Transcribes YouTube video audio    |
| POST   | `/summarize`     | Summarizes given transcript        |
| GET    | `/status/:id`    | (Optional) Check job status        |

---

## ✅ MVP Scope

- [ ] Accept YouTube URL
- [ ] Transcribe with Whisper
- [ ] Summarize with GPT
- [ ] REST API + Web UI
- [ ] Save transcript & summary to DB
- [ ] User authentication (optional)
- [ ] Retry or re-summarize

---

## 📄 License

MIT License

---

## 🙋‍♂️ Contributing

Pull requests are welcome. For major changes, please open an issue first.

---

## 📬 Contact

Got questions or ideas?  
Open an issue or reach out at [sunny.ptel5497@gmail.com](mailto:sunny.ptel5497@gmail.com)
