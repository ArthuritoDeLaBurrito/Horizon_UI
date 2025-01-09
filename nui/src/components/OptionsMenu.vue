<template>
    <div class="menu-container">
      <h2 class="menu-title">Menu des Options</h2>
      <div class="menu-options">
        <div
          v-for="(option, index) in options"
          :key="index"
          class="menu-option"
        >
          <label>
            <input
              type="checkbox"
              v-model="options[index].checked"
            />
            {{ option.label }}
          </label>
        </div>
      </div>
      <button class="menu-button" @click="sendOptionsToLua">
        Valider les Options
      </button>
    </div>
</template>
  
<script setup>
  import { ref } from "vue";
  
  // Liste des options (avec état initial "checked")
  const options = ref([
    { label: "Activer la météo", value: "weather", checked: false },
    { label: "Activer le trafic", value: "traffic", checked: false },
    { label: "Afficher les noms des joueurs", value: "playerNames", checked: false },
    { label: "Activer le chat", value: "chat", checked: false },
    { label: "Mode nuit", value: "nightMode", checked: false },
    { label: "Afficher la minimap", value: "minimap", checked: false },
    { label: "Activer la musique", value: "music", checked: false },
    { label: "Masquer les notifications", value: "notifications", checked: false },
  ]);
  
  // Fonction pour envoyer les options à Lua
  function sendOptionsToLua() {
    // Envoie toute la liste des options avec leurs états
    SendNUIMessage({
      type: "menuOptions",
      data: options.value, // On envoie la liste complète avec leurs états
    });
    console.log("Liste des options envoyée : ", options.value);
  }
</script>
  
<style scoped>
  /* Conteneur principal du menu */
  .menu-container {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 400px;
    height: 300px;
    background: rgba(0, 0, 0, 0.8);
    color: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }
  
  /* Titre du menu */
  .menu-title {
    font-size: 20px;
    margin-bottom: 10px;
    text-align: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.3);
    padding-bottom: 10px;
  }
  
  /* Conteneur des options */
  .menu-options {
    flex: 1;
    overflow-y: auto; /* Permet le scroll si les options dépassent */
    margin-bottom: 10px;
    padding-right: 10px;
  }
  
  /* Option individuelle */
  .menu-option {
    margin-bottom: 10px;
    font-size: 14px;
  }
  
  /* Bouton de validation */
  .menu-button {
    background: rgba(0, 0, 255, 0.7);
    color: white;
    border: none;
    padding: 10px;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
    transition: background 0.3s ease;
  }
  
  .menu-button:hover {
    background: rgba(0, 0, 255, 0.9);
  }
</style>
  