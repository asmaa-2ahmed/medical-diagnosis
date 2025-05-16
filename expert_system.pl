% Enable dynamic predicates
:- dynamic has_symptom/1.
:- dynamic diagnosis/1.
:- dynamic treatment/2.

% Section 1: Symptom Definitions
% -------------------------------
% All possible symptoms the system recognizes

% General symptoms
symptom(fever).                 % Elevated body temperature
symptom(high_fever).            % Fever above 39°C (102°F)
symptom(mild_fever).            % Low-grade fever
symptom(headache).              % Pain in head
symptom(severe_headache).       % Intense headache
symptom(runny_nose).            % Nasal discharge
symptom(congestion).            % Nasal blockage
symptom(sneezing).              % Frequent sneezing
symptom(sore_throat).           % Throat pain
symptom(severe_sore_throat).    % Extreme throat pain
symptom(cough).                 % Coughing
symptom(dry_cough).             % Non-productive cough
symptom(productive_cough).      % Cough with phlegm
symptom(body_ache).             % Muscle pain
symptom(severe_body_ache).      % Intense muscle pain
symptom(chills).                % Feeling cold with shivering
symptom(fatigue).               % Tiredness
symptom(extreme_fatigue).       % Severe exhaustion
symptom(nausea).                % Feeling sick to stomach
symptom(vomiting).              % Throwing up
symptom(diarrhea).              % Loose stools
symptom(rash).                  % Skin irritation
symptom(itchy_eyes).            % Eye irritation
symptom(shortness_of_breath).   % Difficulty breathing
symptom(loss_of_taste).         % Ageusia
symptom(loss_of_smell).         % Anosmia

% -------------------------------
% Section 2: Disease Diagnosis Rules
% -------------------------------
% Each disease has specific symptom combinations

% Common Cold
diagnosis(common_cold) :-
    has_symptom(runny_nose),
    has_symptom(sneezing),
    has_symptom(sore_throat),
    has_symptom(cough),
    (has_symptom(mild_fever) ; \+ has_symptom(fever)),
    \+ has_symptom(high_fever),
    \+ has_symptom(severe_body_ache).

% Influenza (Flu)
diagnosis(flu) :-
    has_symptom(fever),
    has_symptom(headache),
    has_symptom(severe_body_ache),
    has_symptom(chills),
    has_symptom(extreme_fatigue),
    has_symptom(cough),
    \+ has_symptom(rash).

% Allergic Rhinitis (Hay Fever)
diagnosis(allergies) :-
    has_symptom(sneezing),
    has_symptom(runny_nose),
    has_symptom(itchy_eyes),
    has_symptom(congestion),
    \+ has_symptom(fever),
    \+ has_symptom(body_ache).

% Strep Throat
diagnosis(strep_throat) :-
    has_symptom(severe_sore_throat),
    has_symptom(fever),
    has_symptom(headache),
    \+ has_symptom(cough),
    \+ has_symptom(runny_nose).

% COVID-19
diagnosis(covid_19) :-
    (has_symptom(fever) ; has_symptom(high_fever)),
    has_symptom(dry_cough),
    has_symptom(fatigue),
    (has_symptom(loss_of_taste) ; has_symptom(loss_of_smell)),
    (has_symptom(shortness_of_breath) ; \+ has_symptom(shortness_of_breath)).

% Gastroenteritis (Stomach Flu)
diagnosis(gastroenteritis) :-
    has_symptom(nausea),
    has_symptom(vomiting),
    has_symptom(diarrhea),
    (has_symptom(mild_fever) ; \+ has_symptom(fever)),
    \+ has_symptom(severe_sore_throat).

% Migraine
diagnosis(migraine) :-
    has_symptom(severe_headache),
    (has_symptom(nausea) ; has_symptom(vomiting)),
    \+ has_symptom(fever),
    \+ has_symptom(cough).

% Bronchitis
diagnosis(bronchitis) :-
    has_symptom(productive_cough),
    has_symptom(fatigue),
    (has_symptom(mild_fever) ; \+ has_symptom(fever)),
    \+ has_symptom(severe_body_ache).

% Pneumonia
diagnosis(pneumonia) :-
    has_symptom(high_fever),
    has_symptom(productive_cough),
    has_symptom(shortness_of_breath),
    has_symptom(chills),
    has_symptom(fatigue).

% Mononucleosis
diagnosis(mono) :-
    has_symptom(fever),
    has_symptom(severe_sore_throat),
    has_symptom(extreme_fatigue),
    has_symptom(swollen_lymph_nodes),
    \+ has_symptom(productive_cough).

% Default case - unknown illness
diagnosis(unknown_illness) :-
    \+ diagnosis(common_cold),
    \+ diagnosis(flu),
    \+ diagnosis(allergies),
    \+ diagnosis(strep_throat),
    \+ diagnosis(covid_19),
    \+ diagnosis(gastroenteritis),
    \+ diagnosis(migraine),
    \+ diagnosis(bronchitis),
    \+ diagnosis(pneumonia),
    \+ diagnosis(mono).

% -------------------------------
% Section 3: Treatment Recommendations
% -------------------------------
% Each disease has specific treatment suggestions

treatment(common_cold, 
    '1. Rest and hydrate
     2. Use OTC decongestants
     3. Take throat lozenges
     4. Use saline nasal spray
     5. Consider pain relievers for discomfort').

treatment(flu,
    '1. Rest and plenty of fluids
     2. Antiviral medications (if early)
     3. OTC pain/fever reducers
     4. Stay home to prevent spread
     5. Consider flu vaccine for prevention').

treatment(allergies,
    '1. Antihistamines
     2. Nasal corticosteroids
     3. Avoid known allergens
     4. Consider allergy shots (immunotherapy)
     5. Use air purifiers at home').

treatment(strep_throat,
    '1. Antibiotics (prescription required)
     2. Salt water gargles
     3. OTC pain relievers
     4. Throat lozenges
     5. Stay home until 24h on antibiotics').

treatment(covid_19,
    '1. Isolate immediately
     2. Rest and hydrate
     3. Monitor oxygen levels
     4. OTC medications for symptoms
     5. Seek medical care if difficulty breathing
     6. Consider antiviral treatments if eligible').

treatment(gastroenteritis,
    '1. Clear fluids and electrolyte solutions
     2. BRAT diet (bananas, rice, applesauce, toast)
     3. Rest
     4. Avoid dairy and fatty foods
     5. Wash hands frequently to prevent spread').

treatment(migraine,
    '1. Rest in dark, quiet room
     2. OTC pain relievers
     3. Prescription migraine medications
     4. Hydrate
     5. Identify and avoid triggers').

treatment(bronchitis,
    '1. Increase fluid intake
     2. Use humidifier
     3. OTC cough medicine
     4. Rest
     5. Avoid irritants like smoke').

treatment(pneumonia,
    '1. Antibiotics (bacterial) or antivirals (viral)
     2. Rest and fluids
     3. Fever reducers
     4. Hospitalization if severe
     5. Follow-up chest X-ray').

treatment(mono,
    '1. Rest for several weeks
     2. Stay hydrated
     3. OTC pain relievers
     4. Avoid contact sports (risk of spleen rupture)
     5. Gradual return to activities').

treatment(unknown_illness,
    '1. Monitor symptoms closely
     2. Rest and hydrate
     3. Consider telemedicine consultation
     4. Seek emergency care for:
        - Difficulty breathing
        - Persistent high fever
        - Severe dehydration
     5. Keep record of symptom progression').

% -------------------------------
% Section 4: Prevention Advice
% -------------------------------
% General prevention tips for common illnesses

prevention_tip(common_cold,
    '• Wash hands frequently
     • Avoid touching face
     • Disinfect surfaces
     • Avoid close contact with sick people').

prevention_tip(flu,
    '• Annual flu vaccination
     • Good hand hygiene
     • Cover coughs/sneezes
     • Stay home when sick').

prevention_tip(covid_19,
    '• Stay up-to-date with vaccinations
     • Wear masks in crowded places
     • Improve ventilation
     • Test when symptomatic').

% -------------------------------
% Section 5: Utility Predicates
% -------------------------------
% Helper rules for symptom management

% Clear all symptom assertions
clear_symptoms :-
    retractall(has_symptom(_)).

% Assert a symptom
add_symptom(Symptom) :-
    assertz(has_symptom(Symptom)).

% Check if symptom exists
has_symptom(Symptom) :-
    symptom(Symptom),
    clause(has_symptom(Symptom), true).