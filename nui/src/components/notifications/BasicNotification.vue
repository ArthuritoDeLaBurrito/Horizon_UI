<template>
  <div ref="container" id="container">
    <ul id="notif-container">
      <transition name="fade" v-for="(notif, index) in notificationList" :key="index" @after-leave="afterLeave(index)">
        <li class="notification" v-if="notif.show">
          <div>
            <img style="width:2.5em;" v-if="notif.img !== undefined" :src="require('../../assets/img/' + notif.img)" />
            <h4 v-if="notif.title !== undefined" id="title">{{ notif.title }}</h4>
            <hr v-if="notif.title !== undefined">
            <p>{{ notif.msg }}</p>
          </div>
        </li>
      </transition>
    </ul>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const notificationList = ref([]);
const maxNotif = 5;
const count = ref(0);

// Fonction pour créer une notification
function createNotification(notif) {
  notif.show = false;
  notificationList.value.push(notif);
  count.value++;

  setTimeout(() => {
    notif.show = true;

    setTimeout(() => {
      notif.show = false;
    }, 5010);
  }, 10);
}

// Fonction appelée après la disparition d'une notification
function afterLeave(index) {
  notificationList.value.splice(index, 1);
}

// Écoute les événements pour créer des notifications
window.addEventListener('message', (event) => {
  if (event.data.type === 'basicNotification') {
    createNotification({
      img: event.data.logo,
      title: event.data.title,
      msg: event.data.description,
      show: false,
    });
  }
});
</script>

<style scoped>
.fade-enter-active {
  animation: slide-in .7s; /* Animation d'entrée */
}
.fade-leave-active {
  animation: slide-out .7s; /* Animation de sortie */
}

#notif-container {
  font-family: Montserrat;
  list-style-type: none;
  position: absolute;
  right: 1em;
  width: 13em;
  bottom: 2em;
  overflow: hidden;
  padding-bottom: 0.3em;
}

.notification {
  margin-top: 0.4em;
  color: #fff;
  position: relative;
  top: 0.2em;
  width: 100%;
  font-family: 'Montserrat';
}

#notif-container li {
  background-color: black;
  width: 100%;
  border-radius: 10px;
  position: relative;
}

li h4 {
  margin: 0em;
  padding: 0.4em;
  display: inline-block;
  vertical-align: middle;
}

li img {
  display: inline-block;
  vertical-align: middle;
  padding: 0.4em;
  margin: 0em;
}

li hr {
  padding: 0em;
  margin: 0em;
}

p {
  padding: 0.4em;
  margin: 0em;
}
</style>