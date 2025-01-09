<template>
    <div v-if="visible" class="HHThud-container">
      <!-- Barre de vie -->
      <div class="HHThud-element" @click="toggleDetails('health')">
        <p>Vie</p>
        <div class="progress-bar-container">
          <div class="progress-bar health" :style="{ width: health + '%' }"></div>
        </div>
        <!-- Informations supplémentaires -->
        <div v-if="details === 'health'" class="details">
          <p>Votre santé est à {{ health }}%. Prenez des soins si nécessaire.</p>
        </div>
      </div>

      <!-- Barre de faim -->
      <div class="HHThud-element" @click="toggleDetails('hunger')">
        <p>Faim</p>
        <div class="progress-bar-container">
          <div class="progress-bar hunger" :style="{ width: hunger + '%' }"></div>
        </div>
        <!-- Informations supplémentaires -->
        <div v-if="details === 'hunger'" class="details">
          <p>Votre faim est à {{ hunger }}%. Mangez quelque chose pour reprendre des forces.</p>
        </div>
      </div>

      <!-- Barre de soif -->
      <div class="HHThud-element" @click="toggleDetails('thirst')">
        <p>Soif</p>
        <div class="progress-bar-container">
          <div class="progress-bar thirst" :style="{ width: thirst + '%' }"></div>
        </div>
        <!-- Informations supplémentaires -->
        <div v-if="details === 'thirst'" class="details">
          <p>Votre soif est à {{ thirst }}%. Buvez de l'eau pour vous hydrater.</p>
        </div>
      </div>
    </div>

    <div v-if="visible" class="JOPhud-container">
      <!-- Barre de vie -->
      <div class="JOPhud-element">
        <p>Métier</p>
        <p> - {{ job }}</p>
      </div>

      <!-- Barre de faim -->
      <div class="JOPhud-element">
        <p>Illégal</p>
        <p> - {{ gang }}</p>
      </div>

      <!-- Nom Prénom du Joueur -->
      <div class="JOPhud-element">
        <p>Nom / Prénom</p>
        <p> - {{ pname }}</p>
      </div>

       <!-- ID / ID Unique du Joueur -->
      <div class="JOPhud-element">
        <p>ID / ID Unique</p>
        <p> - {{ pid }} / {{ pidu }}</p>     
      </div>
    </div>
    
    <div v-if="visible" class="info-message">
      <p>Les mouvements de caméra et les coups de poing sont désactivés.</p>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

// Données réactives pour le HUD
const health = ref(100);
const hunger = ref(100);
const thirst = ref(100);
const job = ref("unemployed");
const gang = ref("civil");
const pname = ref("Scoubidou Papa");
const pid = ref(0);
const pidu = ref(0);
const details = ref(null); // Identifie quel statut afficher en détail
const visible = ref(false); // État de visibilité du HUD

// Écouter les messages NUI
onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.type === 'updateHud') {
      if (event.data.info.health !== undefined) health.value = event.data.info.health;
      if (event.data.info.hunger !== undefined) hunger.value = event.data.info.hunger;
      if (event.data.info.thirst !== undefined) thirst.value = event.data.info.thirst;
      if (event.data.info.job !== undefined) job.value = event.data.info.job;
      if (event.data.info.gang !== undefined) gang.value = event.data.info.gang;
      if (event.data.info.pname !== undefined) pname.value = event.data.info.pname;
      if (event.data.info.pid !== undefined) pid.value = event.data.info.pid;
      if (event.data.info.pidu !== undefined) pidu.value = event.data.info.pidu;
    }else if (event.data.type === 'toggleHud') { // Afficher ou masquer le HUD
      visible.value = event.data.display; // Affiche ou masque le HUD
      details.value = null; // Réinitialise les détails
    }
  });
});

  // Fonction pour basculer les détails
  function toggleDetails(status) {
    details.value = details.value === status ? null : status;
  }
</script>

<style scoped>
  .HHThud-container {
    position: fixed;
    left: 20px;
    top: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 15px;
    color: white;
    font-family: Arial, sans-serif;
    background: rgba(0, 0, 0, 0.5);
    padding: 10px;
    border-radius: 10px;
    width: 250px;
    animation: fadeIn 0.5s ease-in-out;
  }

  .HHThud-element {
    cursor: pointer;
    text-align: left;
    padding: 5px;
  }

  .HHThud-element:hover {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
  }

  .JOPhud-container {
    position: fixed;
    right: 20px;
    top: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 15px;
    color: white;
    font-family: Arial, sans-serif;
    background: rgba(0, 0, 0, 0.5);
    padding: 10px;
    border-radius: 10px;
    width: 250px;
    animation: fadeIn 0.5s ease-in-out;
  }

  .JOPhud-element {
    cursor: pointer;
    text-align: left;
    padding: 5px;
  }

  .JOPhud-element:hover {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
  }

  /* Conteneur des barres de progression */
  .progress-bar-container {
    width: 100%;
    height: 10px;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 5px;
    overflow: hidden;
    margin-top: 5px;
  }

  /* Barres dynamiques */
  .progress-bar {
    height: 100%;
    transition: width 0.3s ease-in-out;
  }

  .progress-bar.health {
    background: #4caf50;
  }

  .progress-bar.hunger {
    background: #ffc107;
  }

  .progress-bar.thirst {
    background: #03a9f4;
  }

  /* Informations supplémentaires */
  .details {
    margin-top: 10px;
    font-size: 14px;
    background: rgba(0, 0, 0, 0.7);
    padding: 8px;
    border-radius: 5px;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity 0.3s ease;
  }

  .fade-enter-from, .fade-leave-to {
    opacity: 0;
  }

  .info-message {
    position: absolute;
    top: 10%;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 10px 20px;
    border-radius: 8px;
    font-size: 16px;
    z-index: 1000;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
  }
  
  @keyframes fadeIn {
  0% {
    opacity: 0;
    transform: scale(0.9);
  }
  100% {
    opacity: 1;
    transform: scale(1);
  }
}
</style>