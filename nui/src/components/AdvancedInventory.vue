<template>
  <div v-if="visible" class="inventory-container">
    <!-- Barre de recherche -->
    <div class="inventory-header">
      <input type="text" placeholder="Rechercher..." class="search-bar" />
      <div class="inventory-tabs">
        <button class="tab-button active">Grille</button>
        <button class="tab-button">Armes</button>
      </div>
      <div class="inventory-info">
        <p>{{ currentWeight }} / {{ maxWeight }} KG</p>
      </div>
    </div>

    <!-- Inventaire principal -->
    <div class="inventory-grid">
      <div
        v-for="(item, index) in items"
        :key="index"
        class="inventory-item"
        @click="selectItem(item)"
      >
        <img :src="item.icon" alt="Icon" class="item-icon" />
        <div class="item-info">
          <p class="item-name">{{ item.name }}</p>
          <p class="item-weight">{{ item.weight }}kg</p>
        </div>
      </div>
    </div>

    <!-- Informations joueur -->
    <div class="player-info">
      <img src="https://via.placeholder.com/100" alt="Player Avatar" class="player-avatar" />
      <ul>
        <li><b>Âge :</b> 25 ans</li>
        <li><b>Profession :</b> Policier</li>
        <li><b>Argent en poche :</b> $1500</li>
        <li><b>Banque :</b> $5000</li>
      </ul>
    </div>

    <!-- Actions sur l'objet sélectionné -->
    <div v-if="selectedItem" class="item-actions">
      <h3>Actions pour : {{ selectedItem.name }}</h3>
      <p>Poids : {{ selectedItem.weight }} KG</p>
      <button @click="useItem">Utiliser</button>
      <button @click="dropItem">Jeter</button>
      <button @click="giveItem">Donner</button>
    </div>

    <!-- Équipement -->
    <div class="equipment-grid">
      <div v-for="(slot, index) in equipmentSlots" :key="index" class="equipment-slot">
        <img v-if="slot.icon" :src="slot.icon" alt="Slot Icon" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

const items = ref([
  { name: "Taco", weight: 0.3, icon: "../src/assets/img/taco.png" },
  { name: "Radio", weight: 1.0, icon: "../src/assets/img/radio.png" },
  { name: "Faca", weight: 1.2, icon: "../src/assets/img/weapon_knife.png" },
]); // Liste des objets

const currentWeight = ref(2.5); // Poids actuel
const maxWeight = ref(50); // Poids maximum
const selectedItem = ref(null); // Objet sélectionné
const visible = ref(false); // État de visibilité de l'inventaire

const equipmentSlots = ref([
  { name: "Casque", icon: null },
  { name: "Veste", icon: null },
  { name: "Pantalon", icon: null },
]); // Slots d'équipement

// Sélectionner un objet
function selectItem(item) {
  selectedItem.value = item;
}

// Actions sur l'objet
function useItem() {
  console.log(`Utiliser : ${selectedItem.value.name}`);
}

function dropItem() {
  console.log(`Jeter : ${selectedItem.value.name}`);
}

function giveItem() {
  console.log(`Donner : ${selectedItem.value.name}`);
}

window.addEventListener('message', (event) => {
  if (event.data.type === 'toggleInventory') {
    visible.value = event.data.visible; // Met à jour l'état de l'inventaire
  }
  if (event.data.type === 'updateInventory') {
    playerItems.value = event.data.items; // Met à jour les objets
  }
});

document.addEventListener('keydown', (event) => {
      if (event.key === 'Escape') {
        visible.value = false; // Ferme l'inventaire
      }
    });
</script>

<style scoped>
/* Conteneur principal */
.inventory-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  background: rgba(0, 0, 0, 0.9);
  color: white;
  padding: 20px;
  border-radius: 8px;
  width: 90%;
  max-width: 1200px;
  margin: 0 auto;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
}

/* Barre de recherche et navigation */
.inventory-header {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.search-bar {
  flex: 1;
  padding: 10px;
  border-radius: 5px;
  border: none;
  margin-right: 10px;
}

.inventory-tabs {
  display: flex;
  gap: 10px;
}

.tab-button {
  padding: 10px 15px;
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.tab-button.active {
  background: rgba(255, 255, 255, 0.3);
}

.inventory-info {
  font-size: 14px;
}

/* Grille des objets */
.inventory-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
  flex: 1;
}

.inventory-item {
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 8px;
  text-align: center;
  padding: 10px;
  cursor: pointer;
  transition: transform 0.2s;
}

.inventory-item:hover {
  transform: scale(1.05);
}

.item-icon {
  width: 50px;
  height: 50px;
  margin-bottom: 5px;
}

.item-info {
  font-size: 12px;
}

/* Infos joueur */
.player-info {
  width: 25%;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 15px;
}

.player-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  margin-bottom: 15px;
}

/* Actions pour l'objet */
.item-actions {
  flex: 1;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  padding: 15px;
}

button {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  padding: 10px 15px;
  margin: 5px;
  cursor: pointer;
  border-radius: 5px;
}

button:hover {
  background: rgba(255, 255, 255, 0.3);
}

/* Équipement */
.equipment-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}

.equipment-slot {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 8px;
  width: 70px;
  height: 70px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
