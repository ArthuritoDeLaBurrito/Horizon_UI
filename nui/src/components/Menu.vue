<template>
  <div v-if="menuData !== null" :style="menuData?.style?.container" id="container">
    <div v-if="menuData?.banner && menuData.banner.trim() !== ''" class="banner_container"  :style="{   backgroundImage: `url('${menuData.banner}')`, }" >
      <h4>{{ menuData?.title }}</h4>
      <h3>{{btnIndex + 1}} / {{menuData.btn.length}}</h3>
    </div>
    <h1 :style="menuData?.style?.h1" v-if="menuData?.banner == null">{{ menuData?.title }}</h1>
    <ul v-if="menuData?.btn && menuData.btn.length" :style="menuData?.style?.ul">
      <template v-for="(menu, index) in visibleItems" :key="startIndex + index">
        <div v-if="menu.type === 'button'">
          <li
              :class="{ active: (startIndex + index) === btnIndex }"
              :style="(startIndex + index) !== btnIndex ? menuData?.style?.li : menuData?.style?.liActive"
              @click="onButtonClick(menu)"
              class="menu-item"
            >
              {{ menu?.name }}
              <!-- Tooltip -->
              <div v-if="menu.desc && (startIndex + index) === btnIndex" class="tooltip-bottom">
                {{ menu.desc }}
              </div>
            </li>
        </div>
        <div v-if="menu.type === 'checkbox'">
          <li
          :class="{ active: (startIndex + index) === btnIndex }"
          @click="toggleCheckbox(index)"
          class="menu-item"
        >
          <label>
            <input
              type="checkbox"
              v-model="menu.checked"
              :tabindex="(startIndex + index) === btnIndex ? 0 : -1"
            />
            {{ menu.name }} 
          </label>
        </li>
        </div>
      </template>
    </ul>
  </div>
</template>

<script setup>
  import { ref, onMounted, onBeforeUnmount, nextTick, computed} from "vue";

  // Variables réactives
  const tempData = ref([]);
  const btnIndex = ref(0);
  const menuData = ref({
  style: {
  },
  title: "Menu Principal",
  btn: [
    { name: "Option 1", event: "event1", desc: "Description de l'option 1" },
    { name: "Option 2", event: "event2" },
    { name: "Option 3", event: "event3" },
    { name: "Option 4", event: "event3" },
    { name: "Option 5", event: "event3" },
    { name: "Option 6", event: "event3" },
    { name: "Option 7", event: "event3" },
    { name: "Option 8", event: "event3" },
    { name: "Option 9", event: "event3" },
  ],
  });
  const startIndex = ref(0); // Index de départ des éléments visibles
  const maxVisible = 7; // Nombre maximum d'éléments visibles en même temps

  // Calcul dynamique des éléments visibles
  const visibleItems = computed(() => {
    if (!menuData.value?.btn) return [];
    return menuData.value.btn.slice(startIndex.value, startIndex.value + maxVisible);
  });


  function toggleCheckbox(index) {
    const menu = menuData.value.btn[startIndex.value + index];
    console.log("Toggle checkbox :", menu.name);
    menu.checked = !menu.checked;
  }

  // Gérer la navigation avec les flèches haut et bas
  function navigateDown() {
    // Vérifie si on est au dernier élément
    if (btnIndex.value === menuData.value.btn.length - 1) {
      btnIndex.value = 0; // Retourne au premier élément
      startIndex.value = 0; // Réinitialise le défilement au début
    } else {
      btnIndex.value++;

      // Ajuste le défilement si l'élément actif dépasse la fenêtre visible
      if (btnIndex.value >= startIndex.value + maxVisible) {
        startIndex.value++;
      }
    }
  }

  function navigateUp() {
    // Vérifie si on est au premier élément
    if (btnIndex.value === 0) {
      btnIndex.value = menuData.value.btn.length - 1; // Va au dernier élément
      startIndex.value = Math.max(0, menuData.value.btn.length - maxVisible); // Ajuste la fenêtre visible
    } else {
      btnIndex.value--;

      // Ajuste le défilement si l'élément actif dépasse la fenêtre visible
      if (btnIndex.value < startIndex.value) {
        startIndex.value--;
      }
    }
  }

  function menuDown() {
    if (btnIndex.value < menuData.value.btn.length - 1) {
      btnIndex.value++;
      updateActiveButton();
    }
  }

  function arrowUp() {
    if (btnIndex.value > 0) {
      btnIndex.value--;
      updateActiveButton();
    }
  }

  function enter() {
    const btnInfo = menuData.value.btn[btnIndex.value];
    if (btnInfo.type === 'checkbox') {
      btnInfo.checked = !btnInfo.checked;
      return
    }
    if (btnInfo.event) {
      sendEventToLua(btnInfo.event, btnInfo.arg || {});
    }
    if (btnInfo.subMenu) {
      createMenu(btnInfo.subMenu, true);
    }
  }

  function back() {
    if (tempData.value.length <= 1) {
      closeAll();
    } else {
      tempData.value.pop();
      menuData.value = tempData.value[tempData.value.length - 1];
      btnIndex.value = 0;
      updateActiveButton();
    }
  }

  function closeAll() {
    menuData.value = null;
    tempData.value = [];
    btnIndex.value = 0;
  }

  // Utilitaires
  function updateActiveButton() {
    nextTick(() => {
      const menuItems = document.querySelectorAll("#container ul li");
      menuItems.forEach((el, idx) => {
        el.classList.toggle("active", idx === btnIndex.value);
      });
    });
  };

  function sendEventToLua(event, arg) {
    // Envoie un événement vers Lua (par exemple, via NUI)
    fetch(`http://${GetParentResourceName()}/callevent`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ event, arg }),
    });
  };

  function createMenu(data, dynamic = false) {
    if (!dynamic) {
      tempData.value = [];
    } else {
      btnIndex.value = 0;
      nextTick(() => updateActiveButton());
    }
    menuData.value = data;
    tempData.value.push(data);
  };

  window.addEventListener('message', (event) => {
    if (event.data.type === 'createMenu') {
      console.log("Créer un menu :", event.data.menu);
      createMenu(event.data.menu, event.data.dynamic);
    } else if (event.data.type === 'keyPress') {
      if (event.data.key === "ArrowDown") {
        navigateDown()};
      if (event.data.key === "ArrowUp") {
        navigateUp()};
      if (event.data.key === "Enter") enter();
      if (event.data.key === "Backspace") back();
    }
  });

  // Attachez/détachez les événements au montage et démontage
  onMounted(() => {
  });

  onBeforeUnmount(() => {
  });

  function onButtonClick(menu) {
    if (menu.event) {
      sendEventToLua(menu.event);
    }
    console.log("Bouton cliqué :", menu.name);
  }
</script>

<style scoped>
  #container {
    position: absolute;
    width: 300px;
    top: 160px;
    left: 40px;
    margin: 0 auto;
    background: rgba(0, 0, 0, 0.709);
    border-radius: 10px;
    padding: 20px;
    animation: fade-in-out 3s ease forwards;
    transition: bottom 0.3s ease-in-out; /* Transition fluide pour les déplacements */
  }
  
  .banner_container {
    background-image: url('https://s3.amazonaws.com/codecademy-content/courses/freelance-1/unit-2/pattern.jpeg');
    position: relative;
    height: 120px;
    width: 280px;
    right: 10px;
    background-size: cover;
    background-position: center;
    border-radius: 5px;
    justify-content: center;
    align-items: center;
  }

  h4 {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 20px;
    font-weight: bold;
    color: white;
    text-align: center;
    text-shadow: 8px 8px 20px rgb(0, 0, 0);
    
  }

  .menu-item {
    margin: 10px 0;
    cursor: pointer;
  }

  .menu-item.active {
    color: white;
    padding: 10px;
    border-radius: 5px;
  }

  .tooltip-bottom {
    position: absolute;
    bottom: -40px; /* Position juste en bas du menu */
    left: 50%; /* Centré horizontalement */
    transform: translateX(-50%);
    background-color: rgba(0, 0, 0, 0.8);
    color: white;
    padding: 5px 10px;
    border-radius: 5px;
    white-space: nowrap;
    font-size: 14px;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    z-index: 10;
    text-align: center;
    min-width: 80%;
    transition: background 0.3s ease;
  }

  .tooltip-bottom::after {
    content: '';
    position: absolute;
    top: -10px; /* Pointe de la flèche */
    left: 50%;
    transform: translateX(-50%);
    border-width: 10px;
    border-style: solid;
    border-color: transparent transparent rgba(0, 0, 0, 0.8) transparent;
  }

  @keyframes fade-in-out {
    0% {
      opacity: 0;
      transform: translate(0%, -140%);
    }
    10% {
      opacity: 1;
      transform: translate(0%,-140%);
    }
  }

  h1 {
    margin-bottom: 20px;
    font-size: 20px;
    font-weight: bold;
    text-align: center;
    color: white;
  }

  h2 {
    margin-bottom: 18px;
    font-size: 14px;
    text-align: left;
    color: white;
  }

  h3 {
    position: absolute;
    font-size: 12px;
    color: white;
    right: 10px;
    bottom: 10px;
  }

  ul {
    list-style: none;
    padding: 0;
    margin: 0;
    
    overflow-y: auto; /* Permet le scroll vertical */
    scrollbar-width: thin; /* Scroll bar discrète (Firefox) */
  }

  li {
    margin-bottom: 10px;
    padding: 10px;
    background: rgba(128, 128, 128, 0.212);
    color: rgb(255, 255, 255);
    text-align: left;
    border-radius: 5px;
    border-color: rgba(0, 0, 0, 0.486);
    cursor: pointer;
    transition: background 0.3s ease;
  }

  li.active {
    border-left: 5px #4797ff solid;
    text-shadow: rgb(255, 255, 255) 1px 0 5px;
  }

  li:hover {
    background: lightgray;
  }
    
  @keyframes fade-in-out {
    0% {
      opacity: 0;
      transform: translateX(-50%);
    }
    10% {
      opacity: 1;
      transform: translateX(0%);
    }
  }

  label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-size: 14px;
    color: white;
  }

  input[type="checkbox"] {
    margin-right: 10px;
    cursor: pointer;
  }

</style>
