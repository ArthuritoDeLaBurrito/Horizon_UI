<template>
    <div v-if = "visible" class="menu-container">
      <h2 class="menu-title"> {{ title }}</h2>
      <div class="menu-options">
      <div v-for="(option, index) in options"  :key="index" class="menu-option" >
        <label class="checkbox-button">
          <input  type="checkbox"  v-model="options[index].checked"  class="hidden-input" />
          <span class="styled-button">{{ option.label }}</span>
        </label>
      </div>
    </div>
      <button class="menu-button" @click="sendOptionsToLua">
        Valider les Options
      </button>
    </div>
</template>
  
<script setup>
  import { ref, onMounted } from 'vue';
  
  const title = ref("menu"); // Titre du menu
  const options = ref([
  { label: "Activer la météo", value: "weather", checked: false },
  { label: "Activer la météo", value: "weather", checked: false },
  { label: "Activer la météo", value: "weather", checked: false },
  { label: "Activer la météo", value: "weather", checked: false },
  { label: "Activer la météo", value: "weather", checked: false },
  { label: "Activer la météo", value: "weather", checked: false },

]); // Liste des options
  const visible = ref(true); // État de visibilité du menu

  onMounted(() => {
    window.addEventListener('message', (event) => {
      if (event.data.type === 'openMenu') {
        title.value = event.data.title; // Met à jour le titre
        options.value = event.data.options; // Met à jour la liste des options
        visible.value = true; // Affiche le menu
        console.log("Menu affiché avec les options : ", options.value);
      }
    }); 
  });
  // Liste des options (avec état initial "checked")
  // Fonction pour envoyer les options à Lua
  function sendOptionsToLua() {
    // Envoie toute la liste des options avec leurs états
    fetch(`https://${GetParentResourceName()}/returnMenu`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(options.value),
    });
    console.log("Liste des options envoyée : ", options.value);
    visible.value = false
  }
</script>
  
<style scoped>
  /* Conteneur principal du menu */
  .menu-container {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 400px; /* Largeur fixe */
    background: rgba(0, 0, 0, 0.8);
    color: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    display: flex;
    flex-direction: column;
    overflow: hidden; /* Coupe les débordements */
    height: 400px; 
}
  
  /* Titre du menu */
  .menu-title {
    font-size: 20px;
    margin-bottom: 20px; /* Ajoute un espace de 20px sous le titre */
    text-align: center;
    border-bottom: 1px solid rgba(58, 217, 151, 0.9);
    padding-bottom: 10px;
  }
  
  /* Conteneur des options */
  .menu-options {
    display: grid; /* Utilise une grille */
    grid-template-columns: repeat(2, 1fr); /* Deux colonnes */
    gap: 20px; /* Espace entre les options */
    height: 300px; /* Limite maximale de hauteur du menu */
    overflow-y: auto; /* Active le scroll uniquement si nécessaire */
    padding-top: 10px; /* Ajoute un espace à droite pour la scroll bar */
    padding-right: 10px; /* Ajoute un espace à droite pour la scroll bar */
    justify-items: center; /* Centre horizontalement les options */
}

  .menu-options::-webkit-scrollbar {
      display: none; /* Pour Chrome, Safari, et Edge */
  }

  /* Masque le champ input d'origine */
  .hidden-input {
    display: none;
  }

  /* Conteneur du bouton stylisé */
  .checkbox-button {
    display: inline-block;
    margin: 5px 0;
    cursor: pointer;
  }

  /* Bouton stylisé */
  .styled-button {
    width: 150px; /* Fixe une largeur uniforme pour les boutons */
    text-align: center;
    padding: 10px;
    font-size: 14px;
    font-weight: bold;
    color: white;
    background-color: rgba(0, 0, 255, 0.7);
    border: 2px solid rgba(0, 0, 255, 0.9);
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  /* Apparence au survol */
  .checkbox-button:hover .styled-button {
    background-color: rgba(0, 0, 255, 0.9);
  }

  /* Apparence activée (cochée) */
  .hidden-input:checked + .styled-button {
    background-color: rgba(0, 255, 0, 0.7); /* Fond vert lorsqu'il est coché */
    border-color: rgba(0, 255, 0, 0.9);
    color: white;
    box-shadow: 0 0 10px rgba(0, 255, 0, 0.5);
  }

  /* Apparence désactivée (non cochée) */
  .hidden-input:not(:checked) + .styled-button {
    background-color: rgba(255, 255, 255, 0.022); /* Fond rouge lorsqu'il est décoché */
    border-color: rgba(255, 255, 255, 0.254);
  }
  /* Bouton de validation */
  .menu-button { 
    position: absolute;
    background: rgba(37, 37, 40, 0.7);
    color: white;
    border: none;
    padding: 10px;
    font-size: 16px;
    border-radius: 4px;
    width: 300px; /* Largeur fixe */
    bottom: 10px;
    left: 50%; /* Centré horizontalement */
    transform: translateX(-50%);
    cursor: pointer;
    text-align: center;
    transition: background 0.3s ease;
  }
  
  .menu-button:hover {
    background: rgba(58, 217, 151, 0.9);
  }
</style>
  