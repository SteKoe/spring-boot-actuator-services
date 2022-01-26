import axios from "axios";
import {useEffect, useState} from "react";
import {springBootDefinedActuators, springBootVersions} from "./config";

export function App() {
    const [services, setServices] = useState([]);
    const [loading, setLoading] = useState(true);
    const [actuatorSet, setSetOfActuators] = useState(new Set());

    useEffect(() => {
        async function fetch() {
            for (const version of springBootVersions) {
                try {
                    const response = await axios.get(`/app/${version}/actuator`);
                    let links = response.data?._links;
                    let actuators = Object.keys(links)
                        .filter(a => a !== "self")
                        .filter(a => links[a].href.indexOf("{") === -1);

                    actuators.forEach(actuatorSet.add, actuatorSet);
                    setSetOfActuators(new Set(actuatorSet))

                    services.push({
                        version,
                        actuators
                    });
                    setServices([...services]);
                } catch (e) {
                    console.info(`No application found for version ${version}`, e);
                }
            }

            setLoading(false);
        }

        fetch();
    }, [])

    return loading ? (<span>Loading data...</span>) : (
        <table className="table is-striped is-narrow">
            <thead>
            <tr>
                <th rowSpan={2} className="is-vertical-bottom">Actuator</th>
                <th colSpan={services.length} className="has-text-centered has-no-borders">Spring Boot Service
                    Version
                </th>
            </tr>
            <tr>
                {services.map(service => <th key={`${service.version}-header`}>{service.version}</th>)}
            </tr>
            </thead>
            <tbody>
            {[...springBootDefinedActuators].sort().map((actuator, row) => (
                <tr key={`${actuator}-${row}`}>
                    <td>{actuator}</td>
                    {services.map(service => (
                        <th key={service.version + "-" + actuator}>
                            {service.actuators.includes(actuator) ?
                                <i className="far fa-check-circle" /> :
                                <i className="far fa-times-circle" />}
                        </th>
                    ))}
                </tr>
            ))}
            </tbody>
        </table>
    )
}