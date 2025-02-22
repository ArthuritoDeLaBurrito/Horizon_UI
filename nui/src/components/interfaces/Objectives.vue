<template>
    <button class="toggle-button" @click="toggleObjectives">
            🎯
        </button>
    <div class="objective-container">
        <div class="objective-panel" :class="{ 'open': isObjectivePanelOpen }">
            <h3>🎯 {{ title }}</h3>
            <br v-if="objectives.length !== 0" />
            <ul>
                <li v-for="(objective, index) in objectives" :key="index">
                    <span :class="{ 'completed': objective.completed}">{{ objective.text }}</span>
                </li>
            </ul>
        </div> 
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const objectives = ref([]);
const isObjectivePanelOpen = ref(false);
const title = ref("Aucun Objectif en cours");

onMounted(() => {
    window.addEventListener("message", (event) => {
        if (event.data.type === "showObjectives") {
            objectives.value = event.data.objectives;
            title.value = event.data.title;
        }
    });
});

const toggleObjectives = () => {
    isObjectivePanelOpen.value = !isObjectivePanelOpen.value;
};
</script>

<style scoped>
/* 🎯 Conteneur principal */
.objective-container {
    position: fixed;
    top: 20%;
    right: 10px;
}

/* 🎯 Bouton pour ouvrir le panneau */
.toggle-button {
    background-color: rgba(49, 49, 49, 0.253);
    color: white;
    border: none;
    padding: 10px 15px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px;
    position: fixed;
    bottom: 1.5%;
    left: 16%;
}

/* 🎯 Panneau des Objectifs */
.objective-panel {
    position: fixed;
    top: 40%;
    right: -300px;
    width: 250px;
    background-color: rgba(0, 0, 0, 0.527);
    padding: 15px;
    border-radius: 10px 0 0 10px;
    color: white;
    font-size: 16px;
    box-shadow: -3px 0 10px rgba(0, 0, 0, 0.2);
    transition: right 0.3s ease-in-out;
}

.objective-panel.open {
    right: 0;
}

.objective-panel h3 {
    text-align: center;
    margin-bottom: 10px;
}

.objective-panel ul {
    list-style: none;
    padding: 0;
}

.objective-panel li {
    display: flex;
    align-items: center;
    margin-bottom: 8px;
}

.objective-panel input {
    margin-right: 8px;
}


.completed {
    text-decoration: line-through;
}
/* 🎯 Bouton de fermeture */
.close-btn {
    width: 100%;
    margin-top: 10px;
    padding: 8px;
    background: red;
    border: none;
    color: white;
    font-size: 14px;
    cursor: pointer;
    border-radius: 5px;
}
</style>
