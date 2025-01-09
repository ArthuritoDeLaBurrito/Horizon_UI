<template>
  <div id="app">
    <Hud />
    <InfoMessage />
    <Notification />
    <AdvancedInventory />
    <Speedometer />
    <infoStaff />
    <!--<LoadingScreen v-if="showLoadingScreen" />-->
    <!--<component :is="currentPage" :pageData="currentPageData" />-->

  </div>
</template>

<script setup>
  import { ref, reactive, onMounted, onUnmounted } from 'vue';

  // État global pour le chargement
  const showLoadingScreen = ref(true); // True par défaut pour afficher l'écran de chargement

  // Import des composants des pages
  import Home from './views/Home.vue';
  import Example from './views/Example.vue';
  import LoadingScreen from './components/LoadingScreen.vue';
  import Notification from './components/Notification.vue';
  import Hud from './components/Hud.vue';
  import InfoMessage from './components/InfoMessage.vue';
  import AdvancedInventory from './components/AdvancedInventory.vue';
  import Speedometer from './components/Speedometer.vue';
  import infoStaff from './components/infoStaff.vue';

  // Pages disponibles
  const pages = {
    Home,
    Example,
    LoadingScreen,
    Notification,
    AdvancedInventory,
    Speedometer,
    infoStaff
  };

  // Notifications
  const activeNotifications = reactive([]); // Notifications affichées (max 3)
  const notificationQueue = reactive([]);  // Notifications en attente
  let nextId = 1; // ID unique pour les notifications

  // Ajouter une notification
  function addNotification({ message, type = 'info', duration = 3000 }) {
    const notification = { id: nextId++, message, type, duration };
    
    if (activeNotifications.length < 3) {
      activeNotifications.push(notification);
      // Supprime après la durée
      setTimeout(() => removeNotificationById(notification.id), duration);
    } else {
      notificationQueue.push(notification); // Ajoute à la file d'attente
    }
  }

  // Supprimer une notification active par index
  function removeNotification(index) {
    activeNotifications.splice(index, 1);

    // Ajouter la prochaine notification de la file d'attente
    if (notificationQueue.length > 0) {
      const nextNotification = notificationQueue.shift();
      activeNotifications.push(nextNotification);
      // Supprime après la durée
      setTimeout(() => removeNotificationById(nextNotification.id), nextNotification.duration);
    }
  }

  // Supprimer une notification active par ID
  function removeNotificationById(id) {
    const index = activeNotifications.findIndex((notif) => notif.id === id);
    if (index !== -1) {
      removeNotification(index);
    }
  }

  // Variables réactives pour la gestion de l'interface
  const currentPage = ref(null); // Page actuelle
  const currentPageData = reactive({}); // Données associées à la page actuelle

  // Fonction pour changer de page
  function openUI(pageName) {
    if (pages[pageName]) {
      currentPage.value = pages[pageName];
    } else {
      console.warn(`Page "${pageName}" introuvable.`);
    }
  }

  // Fonction pour fermer la page (par exemple en appuyant sur Échap)
  function closeUI() {
    currentPage.value = null;

    // Notifier Lua que l'UI est fermée
    fetch(`https://${GetParentResourceName()}/closeUI`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({}),
    });
  }

  // Fonction pour mettre à jour les données d'une page
  function updatePageData(pageName, data) {
    if (currentPage.value === pages[pageName]) {
      Object.assign(currentPageData, data); // Mise à jour des données
    } else {
      console.warn(`Données reçues pour la page "${pageName}", mais elle n'est pas active.`);
    }
  }

  onMounted(() => {
    // Écouter les messages envoyés depuis Lua

    let progress = 0;
    const interval = setInterval(() => {
      progress += 4;
      if (progress >= 200) {
        if (showLoadingScreen.value) {
          console.log("jesuisencorela")
          clearInterval(interval);
          showLoadingScreen.value = false; // Masquer le loadingscreen une fois terminé 
        }
      }
    }, 500);

    window.addEventListener('message', (event) => {
      if (event.data.type === 'updatePageData') {
        updatePageData(event.data.page, event.data.data); // Appelle la fonction de mise à jour
      } else if (event.data.type === 'notification') {
        addNotification({
          message: event.data.message,
          type: event.data.notificationType,
          duration: event.data.duration,
        });
      } else if (event.data.type === 'openUI') {
        openUI(event.data.page);
      } else if (event.data.type === 'hideLoadingScreen') {
        console.log("jesuisla")
        showLoadingScreen.value = false; // Masquer l'écran de chargement
    }
    });

    // Écoute la touche Échap
    document.addEventListener('keydown', (event) => {
      if (event.key === 'Escape') {
        closeUI(); // Ferme la page en cours
      }
    });
  });

  // Nettoyage des listeners
  onUnmounted(() => {
    window.removeEventListener('message', (event) => {
      if (event.data.type === 'updatePageData') {
        updatePageData(event.data.page, event.data.data);
      }
    });

    document.removeEventListener('keydown', (event) => {
      if (event.key === 'Escape') {
        closeUI();
      }
    });
  });
</script>

<style>
  .notification-container {
    position: fixed;
    bottom: 210px;
    left: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 10px;

    /* Ajout des tailles minimales */
    min-height: 100px; /* Hauteur minimale */
    min-width: 250px;  /* Largeur minimale */
    max-width: 300px;  /* Largeur maximale */
    background-color: rgba(0, 0, 0, 0); /* Légère couleur de fond */
    border-radius: 5px; /* Bord arrondi */
    padding: 10px; /* Espacement interne */
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0); /* Optionnel : ombre */
  }
</style>