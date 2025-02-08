<template>
    <div v-if="list !== null" class="main-container">
        <div class="listButton-contenair">
            <template v-for="(menu, index) in list" :key="index">
                <li 
                    @mouseover="showTooltip(index)" 
                    @mouseleave="hideTooltip"
                    @click="onButtonClick(menu, index)"
                    :class="{'active': activeButton === index, 'blink': activeButton === index}"
                    class="list-item"
                >
                    {{ menu?.label }}
                    <div 
                        v-if="tooltipIndex === index" 
                        class="tooltip-bottom tooltip-visible"
                        >
                            {{ menu.desc }}
                    </div>
                </li>
            </template>
        </div>
        <div class="close-contenair">
            <li @click="onCloseClick()" class="close-text">FERMER</li>
        </div>
    </div>
</template>

<script setup>
  import { ref, onMounted, onBeforeUnmount, nextTick, computed} from "vue";

const list = ref(null);
const tooltipIndex = ref(null); // Index de l'élément actuellement survolé
const activeButton = ref(null); // Index du bouton actif
const eventReturnName = ref(null);

const showTooltip = (index) => {
    tooltipIndex.value = index;
};

const hideTooltip = () => {
    tooltipIndex.value = null;
};

const onButtonClick = (menu, index) => {
    activeButton.value = index;
    fetch(`https://${GetParentResourceName()}/clickButtonList`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            action: "click_buttonList",
            buttonList: menu,
            eventName: eventReturnName.value
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));
};

const onCloseClick = () => {
    fetch(`https://${GetParentResourceName()}/closeButtonList`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({action:"close_buttonList"})
    }).then(resp => resp.json()).then(resp => console.log(resp));
    list.value = null;
};
const disableTabKey = (event) => {
    if (event.key === 'Tab') {
        event.preventDefault();
    }
};

onMounted(() => {
    window.addEventListener('keydown', disableTabKey);
});

onBeforeUnmount(() => {
    window.removeEventListener('keydown', disableTabKey);
});

window.addEventListener('message', (event) => {
    if (event.data.action === 'updateButtonList') {
        console.log(event.data.buttonList);
        list.value = event.data.buttonList;
        eventReturnName.value = event.data.eventName;
    }
});
</script>

<style scoped>
    .main-container {
        position: fixed;
        top: 20%;
        right: 5%;
        width: 12%;
        height: 60%;
        background-color: rgb(34, 34, 39);
        border-radius: 20px;
    }

    .listButton-contenair {
        position: absolute;
        top: 2%;
        left: 5%;
        height: 80%;
        width: 90%;
        border: 1rem solid;
        border-color: rgba(15, 210, 105, 255);
        border-style: inset;
        border-width: 2px;
        border-radius: 2%;
        overflow-y: hidden; /* Initialement masqué */
    }

    .listButton-contenair:hover {
        overflow-y: auto; /* Scrollbar visible au survol */
    }

    .listButton-contenair::-webkit-scrollbar {
        width: 0px;
    }
    .close-contenair {
        position: absolute;
        bottom: 2%;
        left: 5%;
        height: 13%;
        width: 90%;
        border: 1rem solid;
        border-color: rgba(210, 15, 15, 255);
        border-style: inset;
        border-width: 2px;
        border-radius: 2%;
    }

    .close-text {
        position: relative;
        top: 45%;
        left: 10%;
        height: 8%;
        width: 80%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 24px;
        font-weight: bold;
        color: #e4e4e4;
        cursor: pointer;
    }

    .list-item {
        position: relative;
        margin: 10px 0;
        left: 10%;
        height: 8%;
        width: 80%;
        cursor: pointer;
        color: white;
        background-color: rgba(50, 50, 50, 0.826);
        border-radius: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 16px;
        font-weight: bold;
    }

    .list-item:hover {
        background-color: rgba(50, 50, 50, 0.404);
    }

    .tooltip-bottom {
        opacity: 1;
        position: absolute;
        bottom: -40px; /* Position juste en bas de l'élément */
        left: 50%; /* Centré horizontalement */
        transform: translateX(-50%);
        background-color: rgba(0, 0, 0, 0.554);
        color: white;
        padding: 5px 10px;
        border-radius: 5px;
        white-space: nowrap;
        font-size: 14px;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        z-index: 10;
        text-align: center;
        min-width: 80%;
        transition: opacity 0.3s ease;
    }

    .tooltip-visible {
        margin-bottom: 15px; /* Crée un espace sous la tooltip pour éviter le chevauchement */
    }

    .tooltip-bottom::after {
        content: '';
        position: absolute;
        top: -10px;
        left: 50%;
        transform: translateX(-50%);
        border-width: 10px;
        border-style: solid;
        border-color: transparent transparent rgba(0, 0, 0, 0.8) transparent;
    }

    .list-item.active {
        border: 1rem solid;
        border-color: rgba(15, 210, 105, 255);
        border-style: inset;
        border-width: 2px;
        border-radius: 10px;
    }
    .list-item.blink {
        animation: blink-animation 1s infinite;
    }

    @keyframes blink-animation {
        0% { opacity: 1; }
        50% { opacity: 0.5; }
        100% { opacity: 1; }
    }
</style>
