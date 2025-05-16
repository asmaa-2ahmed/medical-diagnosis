import streamlit as st
from pyswip import Prolog
import os
from pathlib import Path

# ==============================================
# INITIALIZATION
# ==============================================
try:
    # Windows users – uncomment and adjust if SWI‑Prolog isn't on PATH
    # os.environ['SWI_HOME_DIR'] = r'C:\Program Files\swipl'

    prolog = Prolog()
    prolog.consult("expert_system.pl")
except Exception as e:
    st.error(f"⚠️ Failed to initialize Prolog: {str(e)}")

# ==============================================
# PAGE CONFIG & CSS
# ==============================================
st.set_page_config(
    page_title="🏥 Medical Diagnosis Expert",
    page_icon="🩺",
    layout="wide",
)

# Inject custom styles (works because we use unsafe_allow_html=True wrappers)
if Path("styles.css").exists():
    with open("styles.css") as css:
        st.markdown(f"<style>{css.read()}</style>", unsafe_allow_html=True)

# ==============================================
# SYMPTOM DATA
# ==============================================
SYMPTOM_GROUPS = {
    "🌡️ General": [
        "fever", "high_fever", "mild_fever", "chills", "fatigue", "extreme_fatigue",
    ],
    "🫁 Respiratory": [
        "cough", "dry_cough", "productive_cough", "shortness_of_breath", "sneezing", "congestion",
    ],
    "🧠 Head/Throat": [
        "headache", "severe_headache", "sore_throat", "severe_sore_throat", "runny_nose", "loss_of_smell",
    ],
    "💪 Body": [
        "body_ache", "severe_body_ache", "joint_pain", "chest_pain", "muscle_weakness",
    ],
    "🥑 Digestive": [
        "nausea", "vomiting", "diarrhea", "abdominal_pain",
    ],
    "✨ Other": [
        "rash", "itchy_eyes", "dizziness", "loss_of_taste", "swollen_lymph_nodes",
    ],
}

ALL_SYMPTOMS = {s for grp in SYMPTOM_GROUPS.values() for s in grp}

# ==============================================
# PROLOG HELPER FUNCTIONS
# ==============================================

def clear_symptoms():
    try:
        list(prolog.query("retractall(has_symptom(_))"))
    except Exception as e:
        st.error(f"Error clearing symptoms: {str(e)}")


def add_symptoms(symptoms):
    clear_symptoms()
    for symptom in symptoms:
        try:
            prolog.assertz(f"has_symptom({symptom})")
        except Exception as e:
            st.warning(f"Could not add symptom '{symptom}': {str(e)}")


def get_diagnosis():
    try:
        results = list(prolog.query("diagnosis(Disease)"))
        if not results:
            return None, None
        disease = results[0]["Disease"]
        treatment_q = list(prolog.query(f"treatment({disease}, Treatment)"))
        return disease, treatment_q[0]["Treatment"] if treatment_q else None
    except Exception as e:
        st.error(f"Diagnosis error: {str(e)}")
        return None, None

# ==============================================
# UI COMPONENTS
# ==============================================

def show_header():
    st.title("🩺 Smart Health Diagnosis")
    st.markdown(
        """
    🔍 **Select your symptoms** from the grid below, then press **Get Diagnosis** to receive a preliminary assessment and self‑care advice. Remember: this tool does **not** replace professional medical evaluation.
    """
    )


def show_symptom_grid():
    """Return a list of symptoms the user selected."""

    search_term = st.text_input("🔎 Search symptoms", "").strip().lower()
    selected = []

    for category, symptoms in SYMPTOM_GROUPS.items():
        # Filter by search term, if provided
        filtered = [s for s in symptoms if search_term in s.replace("_", " ").lower()]
        if not filtered:
            continue

        st.markdown(f"<h3 style='text-align:center'>{category}</h3>", unsafe_allow_html=True)

        cols = st.columns(3)
        for idx, symptom in enumerate(filtered):
            with cols[idx % 3]:
                label = f"🩹 {symptom.replace('_', ' ').title()}"
                if st.checkbox(label, key=f"cb_{symptom}"):
                    selected.append(symptom)
    return selected


def show_diagnosis_result(disease, treatment):
    if not disease:
        st.error("❌ No diagnosis could be determined. Please review your symptoms or consult a professional.")
        return

    emoji_map = {
        "common_cold": "🤧",
        "flu": "🤒",
        "covid_19": "🦠",
        "allergies": "🌸",
        "strep_throat": "🦷",
        "gastroenteritis": "🤢",
        "migraine": "💥",
        "bronchitis": "🫁",
        "pneumonia": "🌬️",
        "mono": "🧬",
        "unknown_illness": "⚠️",
    }
    emoji = emoji_map.get(disease, "⚠️")

    st.markdown('<div class="diagnosis-card">', unsafe_allow_html=True)

    st.subheader(f"{emoji} {disease.replace('_', ' ').title()}")
    st.write(f"**Description**: {get_disease_description(disease)}")

    st.markdown("---")
    st.subheader("💊 Recommended Treatment")
    if treatment:
        st.write("- " + treatment.replace("\n", "\n- "))
    else:
        st.write("Please consult a healthcare professional.")

    st.markdown("---")
    st.subheader("🏡 Self‑Care Tips")
    tips = get_self_care_tips(disease)
    tip_cols = st.columns(2)
    for idx, tip in enumerate(tips):
        with tip_cols[idx % 2]:
            st.write(f"{tip[0]} {tip[1]}")

    st.markdown("</div>", unsafe_allow_html=True)


# ---------------- Helper data for descriptions & tips ----------------

def get_self_care_tips(disease):
    return {
        "common_cold": [
            ("💧", "Drink plenty of fluids"),
            ("🛌", "Get extra rest"),
            ("🌡️", "Use a humidifier"),
            ("🍯", "Try honey for cough"),
        ],
        "flu": [
            ("🏠", "Stay home and rest"),
            ("💊", "Take fever reducers as needed"),
            ("🥣", "Drink warm broth or tea"),
            ("🩺", "Consider antiviral medication"),
        ],
        "allergies": [
            ("🧴", "Use antihistamines"),
            ("🪟", "Keep windows closed"),
            ("🚿", "Shower after being outdoors"),
            ("🧼", "Wash hands frequently"),
        ],
    }.get(
        disease,
        [
            ("🛌", "Get plenty of rest"),
            ("💧", "Stay hydrated"),
            ("📞", "Contact doctor if symptoms worsen"),
        ],
    )


def get_disease_description(disease):
    return {
        "common_cold": "A viral infection affecting your nose and throat (upper respiratory tract).",
        "flu": "Influenza is a contagious viral infection of the respiratory system.",
        "covid_19": "A respiratory illness caused by the SARS‑CoV‑2 virus.",
        "allergies": "An immune system reaction to foreign substances (allergens).",
        "strep_throat": "A bacterial infection causing throat inflammation and pain.",
        "gastroenteritis": "An intestinal infection marked by diarrhea, cramps, nausea, and vomiting.",
        "migraine": "A neurological condition causing intense, debilitating headaches.",
        "bronchitis": "Inflammation of the bronchial tubes, often producing mucus‑filled coughs.",
        "pneumonia": "An infection that inflames the air sacs in one or both lungs.",
        "mono": "A viral infection causing fever, sore throat, and swollen lymph nodes.",
    }.get(disease, "A medical condition that requires attention.")

# ==============================================
# MAIN APP ENTRY
# ==============================================

def main():
    show_header()
    selected_symptoms = show_symptom_grid()

    if st.button("🩺 Get Diagnosis", type="primary"):
        if not selected_symptoms:
            st.warning("⚠️ Please select at least one symptom.")
            return
        with st.spinner("🔍 Analyzing symptoms..."):
            add_symptoms(selected_symptoms)
            disease, treatment = get_diagnosis()
            show_diagnosis_result(disease, treatment)


if __name__ == "__main__":
    main()
