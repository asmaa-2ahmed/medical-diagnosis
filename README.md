# 👨‍⚕️ Medical Diagnosis Expert System - Web App (Streamlit + Prolog)

Welcome to your **intelligent medical diagnosis assistant**! This app combines the power of **Prolog** (a logic programming language) with a modern, interactive **Python Streamlit** frontend. Just select your symptoms and let our virtual doctor suggest a diagnosis, treatment, and helpful prevention tips — all powered by logic rules behind the scenes.

---

## 🧠 Project Idea

This project is a **rule-based expert system** designed to:

* Simulate how a basic AI can reason like a doctor using facts and rules.
* Demonstrate how **Prolog** can be used to define logical relationships (e.g., if you have a fever and cough, you may have the flu).
* Offer a fun, educational example of integrating **traditional AI (Prolog)** with a **modern web interface (Streamlit)**.

Whether you're a student, developer, or just curious about AI, this is a great starter project for learning about **inference engines**, **Prolog**, and **frontend-backend integration**.

---

## 🔍 Overview: How It Works

1. **🧾 Knowledge Base in Prolog**:

   * Contains logic rules for identifying illnesses based on symptoms.
   * Provides treatment recommendations and prevention advice for each illness.

2. **⚙️ Backend using PySwip**:

   * PySwip connects Python to SWI-Prolog, allowing your app to "talk" to Prolog.
   * Sends selected symptoms from Python to Prolog and retrieves the diagnosis.

3. **💻 Frontend in Streamlit**:

   * Displays a list of symptoms for users to choose from.
   * Shows the diagnosis, treatment, and prevention tips.
   * Easy to run in a browser — no need for web development experience!

---

## 📦 Features

* ✅ Clean and user-friendly interface
* 🧠 Logical inference using Prolog
* 💊 Diagnosis with suggested treatments
* 🛡️ Prevention tips for each illness
* 🔁 Easy to expand by adding more rules and symptoms

---

## 📸 Example Usage

1. Run the app

2. Select your symptoms:
   ✅ Fever
   ✅ Cough
   ⬜ Rash
   ⬜ Headache

3. Get your result:

```
✅ Diagnosis: flu  
💊 Treatment: rest, fluids, and fever medication  
🛡️ Prevention Tip: wash hands frequently and avoid close contact
```

---

## 🚀 Getting Started

### 📌 Prerequisites

Before running the app, make sure you have the following installed:

* [Python 3.8+](https://www.python.org/downloads/)
* [SWI-Prolog](https://www.swi-prolog.org/Download.html) (used by PySwip)
* `pip` for installing dependencies

---

### 📁 Installation Steps

1. **Clone the project**

```bash
git clone https://github.com/asmaa-2ahmed/medical-diagnosis
cd medical-diagnosis-app
```

2. **(Optional) Create a virtual environment**

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. **Install dependencies**

```bash
pip install -r requirements.txt
```

4. **Run the app**

```bash
streamlit run app.py
```

---

## 🏗️ Project Structure

```
📁 medical-diagnosis-app
├── app.py             # Streamlit app
├── expert_system.pl      # Prolog knowledge base
├── requirements.txt   # Python dependencies
└── README.md          # Project description
```

---

## 💡 Prolog Sample Logic (expert_system.pl)

```prolog
% Symptoms
symptom(fever).
symptom(cough).
symptom(rash).
symptom(headache).

% Rules
diagnosis(flu) :-
    has_symptom(fever),
    has_symptom(cough).

% Treatment
treatment(flu, 'rest, fluids, and fever medication').

% Prevention
prevention_tip(flu, 'wash hands frequently and avoid close contact').
```

You can easily add more rules and diseases to extend the functionality!

---

## 🧪 Tips for Testing

* Try selecting different combinations of symptoms
* Add new rules to `expert_system.pl` and rerun the app
* Want to diagnose cold? Add:

```prolog
diagnosis(cold) :-
    has_symptom(sore_throat),
    has_symptom(runny_nose).

treatment(cold, 'stay warm, drink plenty of fluids').
prevention_tip(cold, 'avoid touching your face and cover your mouth when sneezing').
```

---

## 📌 Notes

* This project is for **educational/demo purposes only**.
* It is **not intended for real medical use** or diagnosis.
* The logic is based on simple condition matching.

---

## 🤝 Contributions

Got ideas to improve the app? Found a bug?
Pull requests and issues are welcome!

---

## 📄 License

This project is licensed under the MIT License — feel free to use, modify, and share.
