<template>
    <div class="center-container">
    <div class="rect_mid">
      <!-- Contenu du rectangle -->
      <p>Rectangle Centré</p>
    </div>
  </div>
</template>

<script setup>
    import { ref, onMounted } from 'vue';
</script>

<style scoped>

  .center-container {
    display: flex;
    justify-content: center; /* Centre horizontalement */
    align-items: center; /* Centre verticalement */
    height: 100vh; /* Prend toute la hauteur de la fenêtre */
    animation: fadeIn 0.5s ease-in-out
  }
  

  .rect_mid {
    width: 1100px;
    height: 650px;
    background-color: rgba(55, 59, 56, 0.807); /* Couleur de fond */
    border-radius: 10px; /* Coins arrondis */
    border-width: 8px;
    border-color: rgb(26, 148, 83); /* Couleur de la bordure */
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.6); /* Ombre portée */
    display: flex;
    justify-content: center; /* Centre horizontalement le contenu */
    align-items: center; /* Centre verticalement le contenu */
    text-align: center; /* Centre le texte */
    font-size: 16px;
    font-weight: bold;
    color: black;
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