<template>
    <div v-if="visible" class="loading-screen">
      <div class="loading-container">
        <h1>Connexion au serveur...</h1>
        <div class="loading-bar-container">
          <div class="loading-bar" :style="{ width: progress + '%' }"></div>
        </div>
        <p>{{ loadingMessage }}</p>
      </div>
    </div>
</template>
  
<script setup>
  import { ref } from 'vue';
  
  // Définir la visibilité et les données dynamiques
  const visible = ref(true); // True pour afficher l'écran de chargement
  const progress = ref(0); // Progression en pourcentage
  const loadingMessage = ref("Chargement des ressources...");
</script>
  
<style scoped>
  .loading-screen {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, #1e5799, #7db9e8);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }
  
  .loading-container {
    text-align: center;
    color: white;
  }
  
  .loading-bar-container {
    width: 80%;
    height: 10px;
    background: rgba(255, 255, 255, 0.3);
    margin: 20px auto;
    border-radius: 5px;
    overflow: hidden;
  }
  
  .loading-bar {
    height: 100%;
    background: #4caf50;
    transition: width 0.3s ease;
  }
</style>
  