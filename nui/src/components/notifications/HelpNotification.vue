<template>
  <transition name="fade-in">
    <div v-if="message" class="toggleInfo tooltip-animate">{{ message }}</div>
  </transition>
</template>
  
<script setup>
  import { ref } from 'vue';
  const message = ref(null);
  
  // Écoute les messages NUI pour afficher ou masquer l'information
  window.addEventListener('message', (event) => {
    if (event.data.type === 'toggleInfo') {
      message.value = event.data.message;
    }
  });
</script>
  
<style scoped>
  .toggleInfo {
    position: absolute;
    top: 2%;
    left: 2%;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    font-weight: bold;
    padding: 8px 12px;
    border-radius: 4px;
    font-size: 14px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    white-space: pre-wrap; /* Permet les sauts de ligne */
    white-space: pre-line;
    opacity: 1;
    transform: translateY(0);
  }

  /* Ajout de l'animation */
  .fade-in-enter-active {
      transition: opacity 0.5s ease, transform 0.5s ease;
  }
  .fade-in-enter-from {
      opacity: 0;
      transform: translateY(-10px);
  }
</style>
  