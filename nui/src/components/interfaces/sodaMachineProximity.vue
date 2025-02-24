<template>
    <div v-if="dispenserVisible" class="dispenser-container" 
         :class="{ 'fade-in': isFadingIn, 'fade-out': isFadingOut }">
        <span :class="['dispenser-icon', dispenserStatus]">🏧</span>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const dispenserVisible = ref(false);
const isFadingIn = ref(false);
const isFadingOut = ref(false)
const dispenserStatus = ref("green");

onMounted(() => {
    window.addEventListener("message", (event) => {
        if (event.data.type === "showDispenser") {
            dispenserStatus.value = "green"; // 🟢 Distributeur actif
            dispenserVisible.value = true;
            isFadingOut.value = false; // Réinitialiser la disparition
            isFadingIn.value = true; // Activer l'animation d'apparition
        }

        if (event.data.type === "errorDispenser") {
            dispenserStatus.value = "red"; // 🔴 Erreur
            setTimeout(() => {
                isFadingIn.value = false;
                isFadingOut.value = true; // Activer la disparition
                setTimeout(() => {
                    dispenserVisible.value = false;
                }, 1000); // Temps de l'animation
            }, 2000); // Temps avant disparition
        }
    });
});
</script>

<style scoped>
.dispenser-container {
    position: fixed;
    bottom: 2.8%;
    left: 17.3%;
    transform: translate(-50%, -50%);
    font-size: 40px;
    transition: opacity 1s ease-in-out, transform 1s ease-in-out;}

/* Animation d’apparition */
.fade-in {
    opacity: 1;
    transform: translate(-50%, -50%) scale(1.2);
}

/* Animation de disparition */
.fade-out {
    opacity: 0;
    transform: translate(-50%, -50%) scale(0.8);
}


.dispenser-icon.green {
    color: green;
    text-shadow: 0px 0px 10px rgba(0, 255, 0, 0.8);
}

.dispenser-icon.red {
    color: red;
    text-shadow: 0px 0px 10px rgba(255, 0, 0, 0.8);
}
</style>
