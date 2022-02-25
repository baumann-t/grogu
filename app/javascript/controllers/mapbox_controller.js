import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    if (this.markersValue.length > 0) {
    this.map = new mapboxgl.Map({
      container: this.element,
      center: [38.7223, 9.1393],
      pitch: 43.00,
      bearing: 30.4,
      minZoom: 5,
      style: "mapbox://styles/kierandunch/cl019o3cv000d15pbhg5nfk6j",
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    } else {
        this.element.insertAdjacentHTML("afterbegin", "<h4>Sorry, we could not find what you are looking for.</h4>")
    }
  }

  markers = ["fa-brands fa-galactic-republic sith", "fa-solid fa-jedi jedi"]

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement("i")
      customMarker.className = this.markers[Math.floor(Math.random() * this.markers.length)]
      customMarker.style.fontSize = "30px"
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
