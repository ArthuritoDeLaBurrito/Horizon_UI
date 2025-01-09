<template>
    <div v-if="visible" class="info-container" @click="toggleInfo">
      <p class="info_title">Mode Marqueurs</p>
      <transition name="slide">
      <div v-if="showInfo">
        <br />
        <p class="info_text">Reports en attente: {{ rClaim }}</p>
        <p class="info_text">Total des Reports: {{ rTotal }}</p>
        <p class="info_text">Joueurs en ligne: {{ pOnline }}</p>
        <p class="info_text">Staff en ligne: {{ sOnline }}</p>
        <br />
        <p class="info_text">Heure : {{ time }}</p>
        <br />
        <p class="warning_text">Vous ne pouvez jouer en RP</p>
        <p class="warning_text">Pendant votre mode Admin</p>
      </div>
    </transition>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const rClaim = ref(0);
const rTotal = ref(0);
const pOnline = ref(0);
const sOnline = ref(0);
const visible = ref(false); // État de visibilité du HUD
const showInfo = ref(false); // État de visibilité de l'info
const time = ref("00:00");
// Écouter les messages NUI
onMounted(() => {
  window.addEventListener('message', (event) => {
    if (event.data.type === 'updateInfoStaff') {
      if (event.data.info.rClaim !== undefined) rClaim.value = event.data.info.rClaim;
      if (event.data.info.rTotal !== undefined) rTotal.value = event.data.info.rTotal;
      if (event.data.info.pOnline !== undefined) pOnline.value = event.data.info.pOnline;
      if (event.data.info.sOnline !== undefined) sOnline.value = event.data.info.sOnline;
    }else if (event.data.type === 'toggleInfoStaff') { // Afficher ou masquer le HUD
      visible.value = event.data.display; // Affiche ou masque le HUD
    }
  });
  updateTime(); // Met à jour immédiatement
  setInterval(updateTime, 1000); // Met à jour toutes les secondes
});

function updateTime() {
  const now = new Date();
  const hours = now.getHours().toString().padStart(2, "0");
  const minutes = now.getMinutes().toString().padStart(2, "0");
  time.value = `${hours}:${minutes}`;
}

function toggleInfo() {
  showInfo.value = !showInfo.value;
}

</script>

<style scoped>
 
  .info-container {
    position: fixed;
    right: 20px;
    top: 40%;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 15px;
    color: rgb(255, 255, 255);
    font-family: Arial, sans-serif;
    background: rgba(0, 0, 0, 0.5);
    padding: 10px;
    border-radius: 10px;
    width: 250px;
    animation: fadeIn 0.5s ease-in-out;
  }

  .info_title {
    font-size: 20px;
    font-weight: bold;
    color: rgb(162, 50, 50);
    text-align: center;
  }

  .info_text {
    font-size: 16px;
    font-weight: bold;
    color: rgb(255, 255, 255);
    text-align: center;
  }
  .warning_text {
    font-size: 16px;
    font-weight: bold;
    color: rgb(255, 0, 0);
    text-align: center;
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
  /* Animation slide */
  .slide-leave-active {
    transition: all 0.5s ease;
  }

  .slide-enter-from,
  .slide-leave-to {
    transform: translateY(-20px);
    opacity: 0;
    transform: scaleY(0);
    transform-origin: top;
  }

  .slide-enter-to,
  .slide-leave-from {
    transform: translateY(0);
    opacity: 1;
    transform: scaleY(1);

  }

</style>