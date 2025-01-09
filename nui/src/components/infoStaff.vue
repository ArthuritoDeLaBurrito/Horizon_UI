<template>
    <div v-if="visible" class="info-container">
      <p>Les mouvements de caméra et les coups de poing sont désactivés.</p>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const rClaim = ref(0);
const rTotal = ref(0);
const pOnline = ref(0);
const sOnline = ref(0);
const visible = ref(false); // État de visibilité du HUD

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
});

</script>

<style scoped>
  .info-container {
    position: fixed;
    left: 20px;
    top: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 15px;
    color: rgb(0, 0, 0);
    font-family: Arial, sans-serif;
    background: rgba(0, 0, 0, 0.5);
    padding: 10px;
    border-radius: 10px;
    width: 250px;
    animation: fadeIn 0.5s ease-in-out;
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