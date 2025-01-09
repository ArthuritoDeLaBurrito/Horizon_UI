<template>
  <div>
    <!-- Afficher les notifications empilées -->
    <div
      v-for="(notification, index) in activeNotifications"
      :key="index"
      class="notification"
      :style="{ bottom: `${200 + index * 70}px` }"
    >
      <p>{{ notification.message }}</p>
      <!-- Pastille pour le nombre d'occurrences -->
      <div v-if="notification.count > 1" class="badge">
        x{{ notification.count }}
      </div>
    </div>

    <!-- Afficher un indicateur de file d'attente -->
    <div v-if="queue.length > 0" class="queue-indicator">
      +{{ queue.length }} en attente
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const maxNotifications = 3; // Nombre maximum de notifications visibles
const activeNotifications = ref([]); // Notifications visibles
const queue = ref([]); // File d'attente des notifications

// Écoute les messages NUI pour afficher les notifications
window.addEventListener('message', (event) => {
  if (event.data.type === 'showNotification') {
    const newNotification = {
      message: event.data.message,
      duration: event.data.duration || 3000, // Durée par défaut : 3 secondes
      count: 1, // Compteur d'occurrences
    };

    // Vérifie si une notification avec le même message existe déjà
    const existingNotification = activeNotifications.value.find(
      (notif) => notif.message === newNotification.message
    );

    if (existingNotification) {
      // Incrémente le compteur de la notification existante
      existingNotification.count++;
    } else if (activeNotifications.value.length < maxNotifications) {
      // Ajoute une nouvelle notification si moins de 3 affichées
      displayNotification(newNotification);
    } else {
      // Ajoute à la file d'attente si le maximum est atteint
      queue.value.push(newNotification);
    }
  }
});

// Afficher une notification
function displayNotification(notification) {
  activeNotifications.value.push(notification);

  // Retirer la notification après la durée spécifiée
  setTimeout(() => {
    const index = activeNotifications.value.indexOf(notification);
    if (index !== -1) {
      activeNotifications.value.splice(index, 1); // Supprime la notification
      if (queue.value.length > 0) {
        // Affiche la notification suivante de la file d'attente
        const nextNotification = queue.value.shift();
        displayNotification(nextNotification);
      }
    }
  }, notification.duration);
}
</script>

<style scoped>
.notification {
  position: fixed; /* Permet un positionnement relatif à l'écran */
  left: 20px; /* Position fixe à gauche */
  background: rgba(0, 0, 0, 0.7); /* Couleur de fond semi-transparente */
  color: white;
  padding: 10px 20px;
  border-radius: 8px;
  font-size: 16px;
  z-index: 1000;
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
  width: 300px; /* Largeur fixe pour un alignement cohérent */
  animation: fade-in-out 3s ease forwards;
  transition: bottom 0.3s ease-in-out; /* Transition fluide pour les déplacements */
}

/* Décalage dynamique en fonction de la file */
.notification {
  bottom: 20px; /* Position initiale */
}

/* Pastille pour le nombre d'occurrences */
.badge {
  position: absolute;
  top: -5px;
  right: -5px;
  background: red;
  color: white;
  font-size: 12px;
  font-weight: bold;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.5);
}

/* Indicateur de file d'attente */
.queue-indicator {
  position: fixed;
  bottom: calc(20px + 220px); /* Ajusté pour être au-dessus des notifications */
  left: 20px;
  background: rgba(255, 255, 255, 0.1);
  color: white;
  padding: 5px 15px;
  border-radius: 8px;
  font-size: 14px;
  z-index: 1000;
  text-align: center;
}

/* Animation de fade-in et fade-out */
@keyframes fade-in-out {
  0% {
    opacity: 0;
    transform: translateY(20%);
  }
  10% {
    opacity: 1;
    transform: translateY(0%);
  }
  90% {
    opacity: 1;
    transform: translateY(0%);
  }
  100% {
    opacity: 0;
    transform: translateY(20%);
  }
}
</style>
