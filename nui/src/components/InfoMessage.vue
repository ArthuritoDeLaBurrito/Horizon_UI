<template>
    <div v-if="visible" class="info-message">
      <p>{{ message }}</p>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  
  const visible = ref(false);
  const message = ref("");
  
  // Écoute les messages NUI pour afficher ou masquer l'information
  window.addEventListener('message', (event) => {
    if (event.data.type === 'showInfoMessage') {
      message.value = event.data.message;
      visible.value = true;
  
      // Cache le message automatiquement après 3 secondes
      setTimeout(() => {
        visible.value = false;
      }, 3000);
    }
  });
  </script>
  
  <style scoped>
  .info-message {
    position: fixed;
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
    animation: fade-in-out 3s ease forwards;
  }
  
  @keyframes fade-in-out {
    0% {
      opacity: 0;
      transform: translate(-50%, -20%);
    }
    10% {
      opacity: 1;
      transform: translate(-50%, 0%);
    }
    90% {
      opacity: 1;
      transform: translate(-50%, 0%);
    }
    100% {
      opacity: 0;
      transform: translate(-50%, -20%);
    }
  }
  </style>
  