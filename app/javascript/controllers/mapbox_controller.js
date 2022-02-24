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
    this.map = new mapboxgl.Map({
      container: this.element,
      pitch: 43.00,
      bearing: -140.80,
      minZoom: 5,
      center: [-8.634722, 52.511263],
      style: "mapbox://styles/kierandunch/cl019o3cv000d15pbhg5nfk6j"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl }))
  //   if (this.markersValue.length !== 0) {
  //     this.map = new mapboxgl.Map({
  //       container: this.element,
  //       center: [51.5213,0.133],
  //       zoom: 10,
  //       // style: "mapbox://styles/mapbox/streets-v10"
  //       style: "mapbox://styles/kierandunch/cl019o3cv000d15pbhg5nfk6j"
  //     })
  //     this.#addMarkersToMap()
  //     this.#fitMapToMarkers()
  //   } else {
  //     // It can be wahtever I want
  //       this.element.insertAdjacentHTML("afterbegin", "<h4>Sorry, we could not find what you are looking for</h4>")
  //   }
    // this below is the introduction of a search bar in mapbox
    // this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    // mapboxgl: mapboxgl }))
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement("i")
      customMarker.className = "fa-brands fa-galactic-republic"
      customMarker.style.fontSize = "30px"
      customMarker.style.color = "red"
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
