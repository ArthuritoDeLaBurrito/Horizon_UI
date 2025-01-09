<template>
    <div v-if="visible" class="hud-container">
      <!-- Barre de vie -->
      <div class="hud-element" @click="toggleDetails('health')">
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
      <div class="hud-element" @click="toggleDetails('hunger')">
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
      <div class="hud-element" @click="toggleDetails('thirst')">
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
</template>

<script setup>
import { ref, onMounted } from 'vue';

// Données réactives pour le HUD
const health = ref(100);
const hunger = ref(100);
const thirst = ref(100);
const details = ref(null); // Identifie quel statut afficher en détail
const visible = ref(false); // État de visibilité du HUD

// Écouter les messages NUI
onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.type === 'updateHud') {
      if (event.data.health !== undefined) health.value = event.data.health;
      if (event.data.hunger !== undefined) hunger.value = event.data.hunger;
      if (event.data.thirst !== undefined) thirst.value = event.data.thirst;
    } else if (event.data.type === 'toggleHud') { // Afficher ou masquer le HUD
      visible.value = event.data.display; // Affiche ou masque le HUD
    }
  });
});

  // Fonction pour basculer les détails
  function toggleDetails(status) {
    details.value = details.value === status ? null : status;
  }
</script>

<style scoped>
.hud-container {
  position: fixed;
  left: 20px;
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
}

.hud-element {
  cursor: pointer;
  text-align: left;
  padding: 5px;
}

.hud-element:hover {
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
</style>