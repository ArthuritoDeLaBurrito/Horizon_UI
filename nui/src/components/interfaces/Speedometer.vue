<template>
    <div v-if ="visible" class="speedometer" @click="toggleInfo">
      <!-- Barre de carburant circulaire -->
      <svg class="fuel-bar" width="200" height="200">
        <circle
          class="progress-ring__circle"
          stroke="white"
          stroke-width="5"
          fill="transparent"
          r="70"
          cx="100"
          cy="100"
          :style="{ stroke: fuelColor, strokeDashoffset: fuelStrokeOffset }"
          />
      </svg>
  
      
      <!-- Affichage de la vitesse -->
      <div class="speedometer-circle" :class="{ 'emergency-mode': isEmergency }">
        <p class="speed-value">{{ speed }}</p>
        <p class="speed-unit">KM/H</p>
      </div>
  
      <!-- Rapport de transmission -->
      <div class="gear-display">
        <p>{{ gear }}</p>
      </div>

      <!-- Bulle d'Informations -->                 
      <div v-if = "showInfo" class="info-bubble">
        <h3>Informations</h3>
        <p><strong>Vitesse :</strong> {{ speed }} KM/H</p>
        <p><strong>Rapport :</strong> {{ gear }}</p>
        <p><strong>Carburant :</strong> {{ fuel }}%</p>
      </div>
    </div>
  </template>
  
<script setup>
    import { ref, computed } from "vue";
    
    const visible = ref(false); // Contrôle l'affichage du speedometer
    const showInfo = ref(false); // Contrôle l'affichage de la bulle d'infos
    const speed = ref(0); // Vitesse actuelle
    const gear = ref("N"); // Rapport actuel (P, R, N, D ou 1-6)
    const fuel = ref(100); // Niveau de carburant (%)
    const isEmergency = ref(false); // Indique si le véhicule est un véhicule d'urgence

    // Calcul dynamique pour la barre circulaire
    const circleRadius = 90; // Rayon du cercle
    const circleCircumference = 2 * Math.PI * circleRadius; // Circonférence complète
    
    // Décalage de la barre de carburant
    const fuelStrokeOffset = computed(() => {
        const progress = fuel.value / 100; // Convertit le fuel en pourcentage
        return circleCircumference * (1 - progress); // Décalage de la barre
    });
    
    // Écoute des messages NUI pour mettre à jour le speedometer
    window.addEventListener("message", (event) => {
        if (event.data.type === "updateSpeedometer") {
            speed.value = event.data.speed || 0;
            gear.value = event.data.gear || "N";
            fuel.value = event.data.fuel || 0; // Assure que le fuel est valide
            isEmergency.value = event.data.isEmergency || false; // Met à jour si c'est un véhicule d'urgence

            // Rendre visible le speedometer uniquement si le joueur est dans un véhicule
            visible.value = true;
            if (speed.value === 0 && gear.value === "N") {
                showInfo.value = false; // Masquer la bulle d'infos si le véhicule est à l'arrêt
                visible.value = false; // Masquer le speedometer si le véhicule est à l'arrêt
            }
        }
    });
    const fuelColor = computed(() => {
        if (fuel.value > 50) return "green";
        if (fuel.value > 25) return "orange";
        return "red";
    });
    function toggleInfo() {
        showInfo.value = !showInfo.value;
    }
</script>
  
<style scoped>
    /* Mode urgence (animation rouge et bleu) */
    .emergency-mode {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        width: 200px;
        height: 200px;
        animation: emergency 0.5s infinite alternate; /* Alterne entre bleu et rouge */
    }

    @keyframes emergency {
    0% {
        background: rgba(0, 0, 255, 0.27); /* Bleu */
    }
    100% {
        background: rgba(255, 0, 0, 0.27); /* Rouge */
    }
    }

  /* Conteneur principal du speedometer */
    .speedometer {
        position: fixed;
        bottom: 30px; /* Position en bas */
        left: 50%; /* Centré horizontalement */
        transform: translateX(-50%);
        width: 200px;
        height: 200px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    /* Barre de carburant circulaire */
    .fuel-bar {
        position: absolute;
        top: 0;
        left: 0;
        z-index: 1; /* Place la barre derrière le speedometer */
    }

    .progress-ring__circle {
        stroke-dasharray: calc(2 * 3.1416 * 90); /* Circonférence du cercle */
        stroke-dashoffset: calc(2 * 3.1416 * 90); /* Décalage initial (cercle complet) */
        transition: stroke-dashoffset 0.3s ease-in-out; /* Transition fluide */
    }
    /* Contenu du speedometer */
    .speedometer-circle {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        width: 150px;
        height: 150px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(255, 255, 255, 0.1), rgba(0, 0, 0, 0.9));
        z-index: 10; /* Place le speedometer devant la barre circulaire */
    }

    .speed-value {
        font-size: 36px; /* Taille de la vitesse */
        font-weight: bold;
        color: white;
    }

    .speed-unit {
        font-size: 16px;
        color: #aaaaaa;
    }
  
  /* Rapport de transmission */
    .gear-display {
        position: absolute;
        bottom: 40px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 16px;
        color: white;
    }

  /* Bulle d'informations */
    .info-bubble {
        position: absolute;
        top: 50%;
        left: 90%; /* Décalé à droite du speedometer */
        transform: translateY(-50%);
        width: 200px;
        background: rgba(0, 0, 0, 0.566);
        color: white;
        padding: 10px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        z-index: 1;
    }

    .info-bubble h3 {
        margin: 0 0 10px;
        font-size: 18px;
    }

    .info-bubble p {
        margin: 5px 0;
        font-size: 14px;
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
  