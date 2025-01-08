<template>
  <transition name="fade">
    <div v-if="visible" class="hud-container">
      <!-- Barre de vie -->
      <div class="hud-element">
        <p>Vie</p>
        <div class="progress-bar-container">
          <div class="progress-bar health" :style="{ width: health + '%' }"></div>
        </div>
      </div>

      <!-- Barre de faim -->
      <div class="hud-element">
        <p>Faim</p>
        <div class="progress-bar-container">
          <div class="progress-bar hunger" :style="{ width: hunger + '%' }"></div>
        </div>
      </div>

      <!-- Barre de soif -->
      <div class="hud-element">
        <p>Soif</p>
        <div class="progress-bar-container">
          <div class="progress-bar thirst" :style="{ width: thirst + '%' }"></div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script setup>
import { ref, onMounted } from 'vue';

// Données réactives pour le HUD
const health = ref(100);
const hunger = ref(100);
const thirst = ref(100);
const visible = ref(false); // État de visibilité du HUD

// Écouter les messages NUI
onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.type === 'updateHud') {
      if (event.data.health !== undefined) {
        health.value = event.data.health;
        console.log("Vie mise à jour :", health.value); // Log pour vérifier la vie
      }
      if (event.data.hunger !== undefined) {
        hunger.value = event.data.hunger;
        console.log("Faim mise à jour :", hunger.value); // Log pour vérifier la faim
      }
      if (event.data.thirst !== undefined) {
        thirst.value = event.data.thirst;
        console.log("Soif mise à jour :", thirst.value); // Log pour vérifier la soif
      }
    } else if (event.data.type === 'toggleHud') {
      visible.value = event.data.display; // Affiche ou masque le HUD
    }
  });
});
</script>

<style scoped>
.hud-container {
  position: fixed;
  bottom: 20px;
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
  width: 200px;
  opacity: 1;
}

/* Transition fade */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from, .fade-leave-to {
  opacity: 0;
}

/* Conteneur principal des barres de progression */
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

/* Couleurs des barres */
.progress-bar.health {
  background: #4caf50; /* Vert pour la vie */
}

.progress-bar.hunger {
  background: #ffc107; /* Jaune pour la faim */
}

.progress-bar.thirst {
  background: #03a9f4; /* Bleu pour la soif */
}


</style>
