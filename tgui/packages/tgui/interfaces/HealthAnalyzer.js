import { useBackend } from '../backend';
import { Section, ProgressBar, Box, LabeledList, NoticeBox } from '../components';
import { Window } from '../layouts';

export const HealthAnalyzer = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    name,
    stat,
    statstate,
    health,
    tod,
    tdelta,

    bruteLoss,
    fireLoss,
    toxLoss,
    oxyLoss,

    stamLoss,
    cloneLoss,
    brainLoss,

    cardiac,
    husk,
    irradiated,
    protoviral,

    limb_data_lists,
    limbs_damaged,

    organs_damaged,
    organs_missing,

    wounds,
    blood,
    body_data,
  } = data;
  const limb_data = Object.values(limb_data_lists);
  const hStyle = { color: 'red' };
  return (
    <Window width={500} height={500}>
      <Window.Content>
        <Section
          title={name}
          buttons={
            !!stat && (
              <Box inline bold color={statstate}>
                {stat}
              </Box>
            )
          }>
          {stat === 'Dead' ? (
            <NoticeBox danger>
              Time of Death: {tod}
              <br />
              <b>Subject died {tdelta} ago.</b>
            </NoticeBox>
          ) : null}
          <LabeledList>
            <LabeledList.Item label="Health">
              <ProgressBar
                minValue={-0.5}
                value={health / 100}
                ranges={{
                  good: [0.4, Infinity],
                  average: [0.2, 0.4],
                  bad: [-Infinity, 0.2],
                }}>
                {health}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Damage">
              <Box inline minWidth={'75px'}>
                <ProgressBar
                  value={bruteLoss / 150}
                  // maxvalue={150}
                  ranges={{
                    good: [-Infinity, 0.2],
                    average: [0.2, 0.5],
                    bad: [0.5, Infinity],
                  }}>
                  Brute:{bruteLoss}
                </ProgressBar>
              </Box>
              <Box inline width={'5px'} />
              <Box inline minWidth={'75px'}>
                <ProgressBar
                  value={fireLoss / 150}
                  // maxvalue={150}
                  ranges={{
                    good: [-Infinity, 0.2],
                    average: [0.2, 0.5],
                    bad: [0.5, Infinity],
                  }}>
                  Burn:{fireLoss}
                </ProgressBar>
              </Box>
              <Box inline width={'5px'} />
              <Box inline minWidth={'75px'}>
                <ProgressBar
                  value={toxLoss / 150}
                  // maxvalue={150}
                  ranges={{
                    good: [-Infinity, 0.2],
                    average: [0.2, 0.5],
                    bad: [0.5, Infinity],
                  }}>
                  Toxin:{toxLoss}
                </ProgressBar>
              </Box>
              <Box inline width={'5px'} />
              <Box inline minWidth={'75px'}>
                <ProgressBar
                  value={oxyLoss / 150}
                  // maxvalue={150}
                  ranges={{
                    good: [-Infinity, 0.2],
                    average: [0.2, 0.5],
                    bad: [0.5, Infinity],
                  }}>
                  Oxygen:{oxyLoss}
                </ProgressBar>
              </Box>
            </LabeledList.Item>
          </LabeledList>
          <br />
          {protoviral ? (
            <NoticeBox danger>
              Unknown proto-viral infection detected. Isolate immediately.
            </NoticeBox>
          ) : null}
          {cardiac ? <NoticeBox warning>{cardiac}</NoticeBox> : null}
          {husk ? <NoticeBox warning>{husk}</NoticeBox> : null}
          {stamLoss ? <NoticeBox warning>{stamLoss}</NoticeBox> : null}
          {cloneLoss ? <NoticeBox warning>{cloneLoss}</NoticeBox> : null}
          {brainLoss ? <NoticeBox warning>{brainLoss}</NoticeBox> : null}
          {irradiated ? (
            <NoticeBox warning>
              Subject is irradiated. Supply toxin healing.
            </NoticeBox>
          ) : null}
        </Section>
        {limbs_damaged ? (
          <Section title="Limbs Damaged">
            <LabeledList>
              {limb_data.map((limb) => (
                <LabeledList.Item key={limb.name} label={limb.name}>
                  {
                    <>
                      {limb.bruteLoss > 0 ? (
                        <>
                          <Box inline minWidth={'75px'}>
                            <ProgressBar
                              value={limb.bruteLoss / limb.maxDamage}
                              // maxvalue={limb.maxDamage}
                              ranges={{
                                good: [-Infinity, 0.2],
                                average: [0.2, 0.5],
                                bad: [0.5, Infinity],
                              }}>
                              Brute:{limb.bruteLoss}
                            </ProgressBar>
                          </Box>
                          <Box inline width={'5px'} />
                        </>
                      ) : null}
                      {limb.fireLoss > 0 ? (
                        <>
                          <Box inline minWidth={'75px'}>
                            <ProgressBar
                              value={limb.fireLoss / limb.maxDamage}
                              // maxvalue={limb.maxDamage}
                              ranges={{
                                good: [-Infinity, 0.2],
                                average: [0.2, 0.5],
                                bad: [0.5, Infinity],
                              }}>
                              Burn:{limb.fireLoss}
                            </ProgressBar>
                          </Box>
                          <Box inline width={'5px'} />
                        </>
                      ) : null}
                    </>
                  }
                </LabeledList.Item>
              ))}
            </LabeledList>
          </Section>
        ) : null}
        {organs_damaged.length || organs_missing.length ? (
          <Section title="Organs Damaged">
            <LabeledList>
              {organs_damaged.map((organ) => {
                return (
                  <LabeledList.Item key={organ.name} label={organ.name}>
                    {organ.damage ? (
                      <Box inline>
                        <ProgressBar
                          value={organ.damage}
                          maxvalue={organ.damage}
                          ranges={{
                            good: [-Infinity, 10],
                            average: [10, 45],
                            bad: [45, Infinity],
                          }}>
                          Damage:{organ.damage}
                        </ProgressBar>
                      </Box>
                    ) : (
                      <Box
                        inline
                        dangerouslySetInnerHTML={{ __html: organ.status }}
                      />
                    )}
                  </LabeledList.Item>
                );
              })}
              {organs_missing.map((organ) => {
                return (
                  <LabeledList.Item key={organ.name} label={organ.name}>
                    <Box inline>Missing</Box>
                  </LabeledList.Item>
                );
              })}
            </LabeledList>
          </Section>
        ) : null}
        {wounds.length || (blood && blood.bleeding) ? (
          <Section title="Wounds">
            {wounds.map((part, key) => {
              return (
                <div class="examine_block" key={key}>
                  <span class="alert ml-1">
                    <b>
                      Physical trauma{part.wounds.length > 1 ? 's' : ''}{' '}
                      detected in {part.name} <br />
                    </b>
                    <ul>
                      {part.wounds.map((wound, key) => {
                        return (
                          <li class="ml-2" key={key}>
                            {wound.name} ({wound.severity})
                            <br />
                            Recommended treatment: {wound.treat} <br />
                          </li>
                        );
                      })}
                    </ul>
                    <br />
                  </span>
                </div>
              );
            })}
            {blood && blood.bleeding ? (
              <span class="alert ml-1">
                <b>Subject is bleeding!</b>
              </span>
            ) : null}
          </Section>
        ) : null}
        <Section title="Body info">
          {body_data.species ? (
            <span>
              Species: {body_data.species}
              {body_data.mutant ? '-derived mutant' : ''}
              <br />
            </span>
          ) : null}
          {body_data.stability ? (
            <span class="info ml-1">
              Genetic Stability: {body_data.stability}%.
              <br />
            </span>
          ) : null}
          {body_data.core_temp ? (
            <span>
              Core temperature:
              {Math.round(body_data.core_temp - 273.15)} &deg;C (
              {Math.round(body_data.core_temp * 1.8 - 459.67)} &deg;F)
              <br />
            </span>
          ) : null}
          <span>
            Body temperature:
            {Math.round(body_data.body_temp - 273.15)} &deg;C (
            {Math.round(body_data.body_temp * 1.8 - 459.67)} &deg;F )
            <br />
          </span>
        </Section>
      </Window.Content>
    </Window>
  );
};
