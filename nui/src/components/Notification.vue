<template>
  <transition name="slide">
    <div v-if="visible" class="notification" :class="type">
      <p>{{ message }}</p>
    </div>
  </transition>
</template>

<script setup>
  import { ref, onMounted, onUnmounted, watch, nextTick } from 'vue';

  const props = defineProps({
    message: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      default: 'info', // 'info', 'success', 'warning', 'error'
    },
    duration: {
      type: Number,
      default: 3000, // Durée en millisecondes
    },
  });

  const emit = defineEmits(['close']);

  const visible = ref(false);
  let timer;

  onMounted(async () => {
    await nextTick(); // Assure-toi que le DOM est mis à jour
    visible.value = true; // Affiche la notification

    // Masque la notification après la durée spécifiée
    timer = setTimeout(() => {
      closeNotification();
    }, props.duration);
  });

  onUnmounted(() => {
    clearTimeout(timer);
  });

  // Fonction pour fermer la notification
  function closeNotification() {
    visible.value = false;
    emit('close');
  }
</script>

<style scoped>
  .notification-container {
    position: fixed;
    bottom: 200px;
    left: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }

  .queue-indicator {
    margin-top: 10px;
    font-size: 14px;
    color: #fff;
    background-color: rgba(0, 0, 0, 0.6);
    padding: 5px 10px;
    border-radius: 5px;
    text-align: center;
    width: fit-content;
    align-self: flex-start;
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.3);
  }


  .notification.info {
    background-color: #2196F3;
    border-radius: 5px;
  }

  .notification.success {
    background-color: #4CAF50;
    border-radius: 5px;
  }

  .notification.warning {
    background-color: #FFC107;
    color: #000;
    border-radius: 5px;
  }

  .notification.error {
    background-color: #F44336;
    border-radius: 5px;
  }

  /* Animation slide-in et slide-out */
  .slide-enter-active, .slide-leave-active {
    transition: transform 0.5s ease, opacity 0.5s ease;
  }

  .slide-enter-from {
    transform: translateX(-100%); /* Vient de la gauche */
    opacity: 0;
  }

  .slide-enter-to {
    transform: translateX(0); /* Arrête à sa position normale */
    opacity: 1;
  }

  .slide-leave-from {
    transform: translateX(0); /* Position normale */
    opacity: 1;
  }

  .slide-leave-to {
    transform: translateX(-100%); /* Sort vers la gauche */
    opacity: 0;
  }

</style>