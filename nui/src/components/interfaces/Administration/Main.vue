<template>
    <div v-if="visible" class="admin-main">
        <div class="admin-container">
            <div class="admin-personal">
                <h1>Personnel</h1>
            </div>
            <div class="admin-players">
                <h1>Joueurs</h1>
            </div>
            <div class="admin-server">
                <h1>Serveur</h1>
            </div>
        </div>
    </div>
</template>
  
<script setup>
    import { ref, computed } from "vue";
    const visible = ref(false);
</script>
  
<style scoped>
    .admin-main {
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .admin-container {
        position: fixed;
        top: 20%;
        width: 67%;
        height: 60%;
        background-color: rgba(40, 40, 40, 0.711);
        border: 1rem solid;
        border-color: rgba(169, 0, 0, 255);
        border-width: 2px;
        border-radius: 2%;
    }
    .admin-personal {
        position: absolute;
        top: 10%;
        left: 5%;
        width: 20%;
        height: 80%;
        background-color: rgba(40, 40, 40, 0.711);
        border: 1rem solid;
        border-color: rgba(169, 0, 0, 255);
        border-width: 2px;
        border-radius: 2%;
    }
    .admin-players {
        position: absolute;
        top: 10%;
        left: 40%;
        width: 20%;
        height: 80%;
        background-color: rgba(40, 40, 40, 0.711);
        border: 1rem solid;
        border-color: rgba(169, 0, 0, 255);
        border-width: 2px;
        border-radius: 2%;
    }
    .admin-server {
        position: absolute;
        top: 10%;
        right: 5%;
        width: 20%;
        height: 80%;
        background-color: rgba(40, 40, 40, 0.711);
        border: 1rem solid;
        border-color: rgba(169, 0, 0, 255);
        border-width: 2px;
        border-radius: 2%;
    }
    h1 {
        color: white;
        text-align: center;
        font-size: 2rem;
        font-weight: bold;
    }
</style>
  