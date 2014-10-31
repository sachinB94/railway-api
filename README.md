# railway

*An API with various functionalities for indian railways*

## Installation

npm install railway

##Usage

```js
var railway = require('railway')
```

- set API key (optional: uses demo key)

```js
railway.setApikey('<API key>')
```
Demo API is already included, though, our quota may have already exhausted for today.
You may register for a key at http://www.railwayapi.com/pricing/

- Station name to Code

Get station details of given station and nearby stations using station name with automatic name completion.

```js
railway.stationCode('<station name>', function (err, res) {})
```

- Station Code to Name

Get passed railway station and nearby stations details using station code.

```js
railway.stationName('<station code>', function (err, res) {})
```

- LIVE train status

Get live train status.

```js
railway.liveTrainStatus('<train number>', function (err, res) {})
```

- Train route information

Get train’s route information like the list of stoppages,their locations etc.

```js
railway.trainRoute('<train number>', function (err, res) {})
```

- Trains between stations

Get all trains(numbers) running between a source station and destination.

```js
railway.trainBetweenStations('<source>', '<destination>', function (err, res) {})
```

- Train name/number

Get train name using number and vice versa.

```js
railway.name_number('<train name or number>', function (err, res) {})
```
